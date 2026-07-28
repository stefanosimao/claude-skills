# Audit — domain-modeling
*Read-understand-gap @ ed37663 · 74 lines + 3 format refs (skimmed) · 2026-07-28*

**What:** Model-invoked ACTIVE glossary discipline (reading CONTEXT.md is a habit, not this skill; this is for CHANGING the model): challenge terms against the glossary, sharpen fuzzy language, stress-test with invented edge-case scenarios, cross-reference claims against the code and surface contradictions, update CONTEXT.md INLINE the moment a term resolves (never batch). CONTEXT.md = glossary ONLY, zero implementation detail. ADRs offered sparingly — all three gates required: hard to reverse + surprising without context + real trade-off. Files created lazily.
**Dependencies:** setup's domain.md conventions (canonical file layout); consumed by grill-with-docs, triage, wayfinder, improve-codebase-architecture.
**Security:** clean. **Gaps:** none.
**Audit outcome:** clean; the three-gate ADR rule is worth importing into our own decision-log habits.
