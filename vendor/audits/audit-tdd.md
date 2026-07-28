# Audit — tdd (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Red→green discipline reference. Good test = behavior via public interface, reads like a spec, survives refactors. SEAMS: test only at PRE-AGREED seams, confirmed with user before any test. Anti-patterns: implementation-coupled, tautological (assertion recomputes expected value), horizontal slicing (all tests first) → vertical tracer bullets instead. Loop rules: red before green, one slice per cycle, refactoring belongs to review NOT the loop. + tests.md (examples), mocking.md (guidelines). Model-invoked (auto on TDD intent).
**Deps:** CONTEXT.md vocabulary (soft); codebase-design's seam vocabulary (shared language).
**Security:** clean (md only; code snippets are examples).
**Gaps/notes vs extra-code-review tests axis:** tdd governs WRITING tests; nothing of his reviews test QUALITY on a diff — confirmed gap, already assigned to extra-code-review axis 4 (SWE@Google test sizes/flakiness, Percival/Molina). Overlap guard honored: our axis must not re-teach the loop or the anti-pattern list, only judge the diff's arriving tests.
**Audit outcome:** clean; gap confirmed → feeds extra-code-review (already in its spec).
