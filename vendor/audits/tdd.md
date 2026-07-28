# Audit — tdd
*Read-understand-gap @ ed37663 · 36 + tests.md + mocking.md · 2026-07-28*

**What:** Model-invoked red→green discipline. Core moves: tests verify behavior through PUBLIC interfaces at PRE-AGREED SEAMS (confirm seams with the user before any test); anti-patterns named precisely — implementation-coupled, tautological (assertion recomputes expected value), horizontal slicing (all tests first) vs vertical tracer bullets; refactoring explicitly deferred to code-review, not part of the loop. mocking.md: mock at system boundaries only, DI + SDK-style interfaces for mockability. tests.md: worked good/bad examples incl. verify-through-interface-not-DB.
**Dependencies:** CONTEXT.md/ADRs (soft, vocabulary); pairs with implement + code-review.
**Security:** clean. **Gaps:** examples are TS but principles are language-neutral; the tests-QUALITY-on-a-diff review gap is already assigned to extra-code-review's tests axis (SWE@Google, Percival, Molina) — this skill governs *writing*, ours reviews *what arrived*.
**Audit outcome:** clean; complements already planned, no new material.
