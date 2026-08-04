#!/usr/bin/env python3
"""
yt-gemini bridge — sends a YouTube URL + a question to Gemini's native video
understanding API and prints the text answer. Stdlib only, no pip install.

Usage:
    python3 yt_gemini.py "<youtube_url>" "<question>" [--model gemini-flash-latest]

Requires GEMINI_API_KEY in the environment. Never hardcode it in this file —
export it in your shell profile (~/.zshrc, ~/.bashrc) or a project-scoped
.claude/settings.local.json (git-excluded by Claude Code automatically).
"""
import argparse
import json
import os
import sys
import urllib.error
import urllib.request

API_BASE = "https://generativelanguage.googleapis.com/v1beta/models"


def main() -> None:
    parser = argparse.ArgumentParser(description="Ask Gemini about a YouTube video.")
    parser.add_argument("url", help="YouTube video URL")
    parser.add_argument("question", help="What to ask about the video")
    parser.add_argument(
        "--model",
        default="gemini-flash-latest",
        help="Gemini model alias (default: gemini-flash-latest, auto-updating)",
    )
    args = parser.parse_args()

    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        print(
            "GEMINI_API_KEY is not set. Export it in your shell profile — "
            "see skills/yt-gemini/SKILL.md. Not proceeding.",
            file=sys.stderr,
        )
        sys.exit(1)

    payload = {
        "contents": [
            {
                "parts": [
                    {"file_data": {"file_uri": args.url}},
                    {"text": args.question},
                ]
            }
        ]
    }

    # Key goes in a header, never the query string: ?key= lands in proxy and
    # gateway logs and can surface in exception text.
    endpoint = f"{API_BASE}/{args.model}:generateContent"
    req = urllib.request.Request(
        endpoint,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "x-goog-api-key": api_key,
        },
        method="POST",
    )

    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            body = json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        detail = e.read().decode("utf-8", errors="replace")
        print(f"Gemini API error {e.code}: {detail}", file=sys.stderr)
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Network error reaching Gemini: {e.reason}", file=sys.stderr)
        sys.exit(1)

    try:
        parts = body["candidates"][0]["content"]["parts"]
        text = "".join(p.get("text", "") for p in parts)
    except (KeyError, IndexError):
        print(f"Unexpected response shape:\n{json.dumps(body, indent=2)}", file=sys.stderr)
        sys.exit(1)

    print(text)


if __name__ == "__main__":
    main()
