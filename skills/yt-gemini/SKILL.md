---
name: yt-gemini
description: "Bridges to Gemini's native video API so Claude can understand what's actually IN a YouTube video — visuals, on-screen action, audio — not just captions, which Claude cannot do natively. Use when a YouTube URL is shared and the user wants it watched, summarized, or asked about ('what happens in this video', 'summarize this YT link', 'what does he do at 3:40'). Do NOT use for a plain transcript dump with nothing to analyze — paste the transcript directly instead. Local Claude Code only — needs live network access to Gemini's API plus a shell-inherited API key, which neither claude.ai's sandbox nor cloud sessions provide."
---

# yt-gemini

The one thing Claude can't do natively is watch or listen to a video. This skill hands that job to Gemini, which can, and folds the answer back into the conversation as **Gemini's read of the video — not a Claude-verified fact.**

## Step 1 — Confirm the environment

Check the key is set: `[ -n "$GEMINI_API_KEY" ] && echo present || echo missing`.

**Completion criterion:** key confirmed present, OR the user is told plainly to export `GEMINI_API_KEY` in their shell profile — never proceed on a placeholder, and never guess at the video's content from its title/thumbnail instead of calling the bridge.

## Step 2 — Call the bridge script

```
python3 <skill-dir>/scripts/yt_gemini.py "<youtube_url>" "<question or task>" [--model gemini-flash-latest]
```

- `--model` defaults to `gemini-flash-latest` — Google's auto-updating alias, so this script doesn't go stale as Gemini renames releases. Swap to `gemini-pro-latest` for harder visual/reasoning questions.
- The question can reference timestamps directly ("what's shown at 3:40") — Gemini resolves these from the video itself.

**Completion criterion:** script exits 0 with printed text, OR a Gemini/network error is surfaced to the user verbatim. Never silently retry into a guess.

## Step 3 — Attribute the answer

State the answer as Gemini's read, not Claude's own observation — Claude never saw the frames. If the video is private, unlisted, age-gated, or region-locked, Gemini will error on the fetch; surface that error rather than inferring content from context.

## Surface

**Local Claude Code only.** The key arrives by process inheritance — exported in the shell profile, inherited by Claude Code and every Bash child it spawns — so it never enters the repo or the context window. Three surfaces can't support that:

- **claude.ai** — sandboxed code execution has no network route to Gemini's API.
- **Cloud sessions** — no secrets store; the environment-variable field is readable by anyone with access to that environment, so the key doesn't belong there.
- **Cloud sessions again** — they load only skills committed to `.claude/skills/`, not the `~/.claude/skills/` that `sync.sh` writes locally.

If invoked where the bridge can't run, say so plainly and offer the alternative — a transcript-only reading, which covers spoken content but not what is shown.

## Reference

- `scripts/yt_gemini.py` — stdlib-only (urllib), no `pip install` needed.
- Public YouTube videos only. Long videos can hit Gemini's daily processing cap — if the call fails on this, say so; don't silently truncate the question or fall back to a caption-only guess.
- Never echo `$GEMINI_API_KEY` in output, logs, or error messages.
