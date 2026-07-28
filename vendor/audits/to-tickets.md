# Audit — to-tickets
*Read-understand-gap @ ed37663 · 105 lines · 2026-07-28*

**What:** User-invoked Phase-5: breaks spec/plan/conversation into TRACER-BULLET tickets — vertical slices cutting a complete path through every layer, each demoable alone, sized to one fresh context window, each declaring its BLOCKING edges. Quizzes the user on granularity/edges before publishing (local files under .scratch/<feature>/issues/NN-*.md, or native blocking links on a real tracker; blockers published first so edges can reference real ids). Work proceeds on the FRONTIER (all blockers done).
**Signature move:** wide refactors escape vertical slicing via EXPAND–CONTRACT: add new form beside old → migrate call sites in blast-radius-sized batches (each a ticket) → contract/delete when no caller remains; integration branch fallback when even batches can't stay green.
**Dependencies:** tracker + setup (hard); glossary/ADRs (soft). Feeds: implement, wayfinder, code-review (spec axis reads the parent).
**Security:** clean. **Gaps:** none.
**Audit outcome:** clean; no complement material.
