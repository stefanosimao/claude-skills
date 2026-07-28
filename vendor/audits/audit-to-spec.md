# Audit — to-spec (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Synthesize the CURRENT conversation into a spec/PRD (no interview) and publish to the tracker with ready-for-agent label. Notable: seam-first (sketch test seams BEFORE writing, prefer existing/highest/fewest — "ideal number is one", confirm with user); template = Problem/Solution/LONG user-story list/Implementation Decisions (no file paths — they go stale; exception: prototype-derived decision snippets)/Testing Decisions/Out of Scope. `disable-model-invocation: true`.
**Deps:** issue-tracker.md + triage labels (setup); CONTEXT.md vocabulary + ADRs; upstream: grilling produced the conversation; downstream: to-tickets consumes the spec.
**Security:** clean.
**Gaps/notes:** (1) "Describe the end state, not the journey" (Phase 4 doctrine) enforced by the no-paths rule. (2) The seam-confirmation step is where software-engineering (complement) naturally gets called for a second opinion — alongside, not inside.
**Audit outcome:** clean; no complement material.
