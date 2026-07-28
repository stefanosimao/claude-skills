# Audit — grilling (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** The core interview discipline: relentless one-question-at-a-time interrogation of a plan/decision until shared understanding, walking the decision tree, recommending an answer per question, looking up facts itself (asks only for *decisions*), acting nothing until confirmed. Model-invoked (no disable flag) — fires on "grill" trigger phrases or stress-test intent.
**Deps:** none. Consumed BY grill-me, grill-with-docs, wayfinder, triage, improve-codebase-architecture (they all "run a /grilling session").
**Security:** clean — 8 lines of prose, no writes, no scripts.
**Gaps/notes:** (1) The one-question-at-a-time + recommended-answer pattern is the same interaction contract as claude.ai's option-elicitation — no complement needed. (2) It's the *only* auto-invoked member of the grilling trio; grill-me/grill-with-docs are thin user-invoked wrappers. Trigger namespace check (dossier watchlist): internal overlap is hierarchical, not competitive — no collision. interview-answer-coach rebuild must avoid "grill" phrasing in its description.
**Audit outcome:** clean; no complement material. The trio question is resolved: wrappers + engine, by design.
