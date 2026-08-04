#!/usr/bin/env python3
"""
yt-gemini bridge — sends a YouTube URL + a question to Gemini's native video
understanding API and prints the text answer. Stdlib only, no pip install.

Skill/agent invocation — the safe form, because nothing user-derived is ever
interpolated into a shell word. A quoted heredoc delimiter suppresses every
expansion, including $(...) and backticks:

    python3 yt_gemini.py [--model gemini-flash-latest] <<'YT_GEMINI_EOF'
    <youtube_url>
    <question, may span several lines>
    YT_GEMINI_EOF

Manual invocation, for a URL and a question you typed yourself:

    python3 yt_gemini.py "<youtube_url>" "<question>"

Requires GEMINI_API_KEY in the environment. Never hardcode it in this file —
export it in your shell profile (~/.zshrc, ~/.bashrc). That is the only
location this skill assumes.

Do NOT assume a settings file is git-excluded for you. `.claude/settings.local.json`
is ignored on the author's machine because of a *global* gitignore rule
(~/.config/git/ignore), not because of anything Claude Code or this repo does.
A fresh clone on a machine without that rule would commit a live key. This
repo's .gitignore now excludes the path explicitly; any other repo you copy
this script into does not. Verify with `git check-ignore -v <path>` before a
live key goes anywhere near a tracked tree.
"""
import argparse
import json
import os
import re
import sys
import urllib.error
import urllib.request

API_BASE = "https://generativelanguage.googleapis.com/v1beta/models"
REQUEST_TIMEOUT = 120

# The model name is interpolated into the request path, so it is restricted to
# characters that cannot start a new path segment, a query string or a fragment.
MODEL_RE = re.compile(r"^[A-Za-z0-9._-]+$")


def fail(message: str) -> "None":
    print(message, file=sys.stderr)
    sys.exit(1)


def read_request(url: "str | None", question: "str | None") -> "tuple[str, str]":
    """Resolve (url, question) from argv if both were given, else from stdin.

    Stdin format: first non-blank line is the URL, everything after it is the
    question. This is the form the skill uses — see the module docstring for why.
    """
    if url is not None and question is not None:
        return url, question
    if url is not None or question is not None:
        fail(
            "Pass both the URL and the question as arguments, or pass neither "
            "and supply them on stdin (first line URL, rest question)."
        )

    lines = sys.stdin.read().splitlines()
    for i, line in enumerate(lines):
        if line.strip():
            stdin_url = line.strip()
            stdin_question = "\n".join(lines[i + 1 :]).strip()
            break
    else:
        fail("No arguments given and stdin was empty. Nothing to ask about.")

    if not stdin_question:
        fail(
            "Read a URL from stdin but no question after it. Put the URL on the "
            "first line and the question on the lines below it."
        )
    return stdin_url, stdin_question


def main() -> None:
    parser = argparse.ArgumentParser(description="Ask Gemini about a YouTube video.")
    parser.add_argument("url", nargs="?", help="YouTube video URL (or omit and use stdin)")
    parser.add_argument("question", nargs="?", help="What to ask about the video")
    parser.add_argument(
        "--model",
        default="gemini-flash-latest",
        help="Gemini model alias (default: gemini-flash-latest, auto-updating)",
    )
    args = parser.parse_args()

    if not MODEL_RE.match(args.model):
        fail(
            f"Refusing model name {args.model!r}: only letters, digits, dot, "
            "underscore and hyphen are allowed. The name goes into the request "
            "path, where anything else could redirect the call to another method."
        )

    url, question = read_request(args.url, args.question)

    api_key = os.environ.get("GEMINI_API_KEY")
    if not api_key:
        fail(
            "GEMINI_API_KEY is not set. Export it in your shell profile — "
            "see skills/yt-gemini/SKILL.md. Not proceeding."
        )

    payload = {
        "contents": [
            {
                "parts": [
                    {"file_data": {"file_uri": url}},
                    {"text": question},
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
        with urllib.request.urlopen(req, timeout=REQUEST_TIMEOUT) as resp:
            raw_body = resp.read()
    except urllib.error.HTTPError as e:
        detail = e.read().decode("utf-8", errors="replace")
        e.close()
        fail(f"Gemini API error {e.code}: {detail}")
    except urllib.error.URLError as e:
        fail(f"Network error reaching Gemini: {e.reason}")
    except OSError as e:
        # A stall *after* the response headers arrive raises TimeoutError, which
        # is an OSError and not a URLError, so it would otherwise escape both
        # handlers above and print a traceback. Long videos hit this path.
        fail(
            f"Network error reaching Gemini after {REQUEST_TIMEOUT}s: {e}. "
            "A long video can exceed the timeout while Gemini is still ingesting it."
        )

    try:
        body = json.loads(raw_body.decode("utf-8"))
    except ValueError as e:
        # Covers JSONDecodeError and UnicodeDecodeError (both ValueError):
        # captive portals and proxy error pages return HTML with a 200.
        preview = raw_body[:500].decode("utf-8", errors="replace")
        fail(f"Gemini returned a body that is not valid UTF-8 JSON ({e}). First 500 bytes:\n{preview}")

    try:
        parts = body["candidates"][0]["content"]["parts"]
        text = "".join(p.get("text", "") for p in parts)
    except (KeyError, IndexError, TypeError, AttributeError):
        # TypeError: "parts": null, or a body that is a JSON array.
        # AttributeError: parts holding bare strings rather than objects.
        fail(f"Unexpected response shape:\n{json.dumps(body, indent=2)}")

    print(text)


if __name__ == "__main__":
    main()
