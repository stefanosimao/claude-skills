# Audit — git-guardrails-claude-code
*Read-understand-gap @ ed37663 · 95 lines + script · 2026-07-28*

**What:** Sets up a PreToolUse hook blocking dangerous git (push all variants, reset --hard, clean -f/-fd, branch -D, checkout./restore.) before execution. Asks scope (project vs global), copies the bundled script, MERGES the hook into settings.json (never overwrite), offers pattern customization, verifies with a piped test expecting exit 2.
**Script (read line-by-line):** stdin JSON → jq extracts command → grep -E against pattern list → exit 2 + BLOCKED message. Purely defensive; no network, no writes. Hooks-over-prose in the flesh — enforcement Claude can't talk itself out of.
**Security:** clean, but note this skill performs the HIGHEST-PRIVILEGE write in the whole set (settings.json). Model-invoked by description; process rule for us: treat as run-deliberately, and review the merged settings after.
**Dependencies:** jq. Pairs with implement (commit yes, push no → AFK-safe).
**Gaps:** pattern list is regex-greppable and bypassable by a determined agent (e.g. env tricks) — it's a guardrail, not a sandbox; fine for its purpose.
**Audit outcome:** clean; adopt on personal laptops during Phase 1 testing.
