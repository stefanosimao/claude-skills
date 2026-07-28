# Audit — git-guardrails-claude-code (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Installs a PreToolUse hook (scripts/block-dangerous-git.sh) blocking: git push (all variants), reset --hard, clean -f/-fd, branch -D, checkout ./restore . — project or global scope, settings.json merge instructions (never overwrite existing hooks). Model-invoked (on "prevent destructive git" intent).
**Deps:** Claude Code hooks system; jq (the script uses it).
**Security:** the script READ LINE-BY-LINE (audit of 2026-07-28, vendoring pass): stdin → jq extract command → grep against fixed pattern list → exit 2 with message. Purely defensive, no network, no writes. CLEAN. Note: patterns are grep -E substrings — bypassable by exotic quoting; it's a guardrail, not a sandbox. Acceptable as designed.
**Gaps/notes:** (1) THE hooks-over-prose exemplar — deterministic enforcement instead of CLAUDE.md pleading; cite it in skill-forge's "should this rule be a hook?" check. (2) Blocking `git push` conflicts with implement's "commit to current branch" workflow only at push time — intended: human pushes. Adopt globally on personal laptops? → send/scope/block call for the next audit ledger, not decided here.
**Audit outcome:** clean (script verified); no complement material.
