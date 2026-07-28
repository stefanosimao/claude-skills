# Audit — to-tickets (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Break spec/plan/conversation into TRACER-BULLET vertical-slice tickets with blocking edges; quiz the user on granularity/edges before publishing; publish in dependency order (local files .scratch/<feature>/issues/NN-*.md or native tracker issues + blocking links, ready-for-agent). Exception doctrine: WIDE REFACTORS (one mechanical change, codebase-wide blast radius) become expand→migrate-in-batches→contract sequences, optional integration branch when batches can't stay green. `disable-model-invocation: true`.
**Deps:** issue-tracker.md + labels (setup); CONTEXT.md/ADRs; upstream to-spec; downstream implement/wayfinder-frontier.
**Security:** clean.
**Gaps/notes:** (1) Vertical-slice + blocking-edges is what makes Phase 6 parallelizable/AFK-able. (2) Expand-contract guidance is a genuinely strong pattern; extra-code-review's defect axis should NOT re-teach it (overlap guard).
**Audit outcome:** clean; no complement material.
