# Audit — codebase-design
*Read-understand-gap @ ed37663 · 114 lines + DEEPENING.md/DESIGN-IT-TWICE.md (skimmed) · 2026-07-28*

**What:** Model-invoked VOCABULARY skill for deep modules — the terms are the payload, used exactly: module / interface (everything a caller must know, not just the type surface) / implementation / depth (leverage per unit of interface) / seam (Feathers) / adapter / leverage (callers) / locality (maintainers). Principles: depth is a property of the interface; the DELETION TEST; the interface is the test surface; one adapter = hypothetical seam, two = real. Explicitly REJECTED framings documented (Ousterhout's line-ratio depth; interface-as-keyword; "boundary"). Refs: DEEPENING (dependency categories, replace-don't-layer testing), DESIGN-IT-TWICE (parallel sub-agents design the interface radically differently, compare on depth/locality/seam).
**Dependencies:** none; consumed by improve-codebase-architecture, tdd/to-spec (seam language), domain-modeling (adjacent).
**Security:** clean.
**Implication for software-engineering (Layer 2):** must ADOPT this vocabulary, never restate it — its value-add is canon grounding (Ousterhout-as-written, GoF, Fowler, DDIA chapters) and my standards, i.e. exactly what this skill's "rejected framings" section shows Matt deliberately diverges from. Where they disagree (depth definition), our skill presents both, cites chapters, and defers to Matt's vocabulary inside pipeline work.
**Audit outcome:** clean; key design input for software-engineering.
