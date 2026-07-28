# Audit — resolving-merge-conflicts
*Read-understand-gap @ ed37663 · 14 lines · 2026-07-28*

**What:** Model-invoked 5-step procedure for in-progress merge/rebase conflicts: see state → find PRIMARY sources per conflict (commit messages, PRs, original issues — intent, not text) → resolve each hunk preserving both intents where possible → run the project's checks → finish the merge/rebase.
**Opinionated rules to know:** "Do NOT invent new behaviour. Always resolve; never --abort." The no-abort stance is deliberate (an agent that aborts learns nothing) but worth knowing before pointing it at a genuinely wrong merge.
**Dependencies:** none hard; reads tracker/PRs when available. **Security:** clean.
**Audit outcome:** clean; no complement material.
