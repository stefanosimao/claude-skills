# Audit — resolving-merge-conflicts (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** 5-step conflict procedure: see state → find PRIMARY SOURCES per conflict (commit messages, PRs, original tickets — understand both intents) → resolve each hunk preserving both intents where possible, pick per the merge's stated goal where not, NEVER invent behaviour, always resolve never --abort → discover and run the project's checks → finish (stage, commit, continue rebase to completion). Model-invoked.
**Deps:** git; tracker (reading original tickets) soft.
**Security:** clean. "Never --abort" is aggressive but is a completion discipline, not a danger; git-guardrails still blocks push/reset --hard around it.
**Audit outcome:** clean; no complement material.
