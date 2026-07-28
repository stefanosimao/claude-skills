# Audit — implement (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** 5-line executor: implement from spec/tickets, /tdd at pre-agreed seams, typecheck + single-test-files regularly + full suite once at end, /code-review when done, commit to current branch. `disable-model-invocation: true`.
**Deps:** tdd, code-review skills; spec/tickets from upstream; tracker config indirectly.
**Security:** clean. Note: commits (allowed) but git-guardrails blocks push/reset if installed — good pairing.
**Gaps/notes:** Deliberately thin — the discipline lives in tdd/code-review; implement is the Phase-6 glue. This is where extra-code-review slots in BY THE USER after /code-review (manual, alongside), and where software-engineering may fire mid-work (model-invoked complement) — both outside implement's text, per the verbatim rule.
**Audit outcome:** clean; no complement material (the complements attach around it, not in it).
