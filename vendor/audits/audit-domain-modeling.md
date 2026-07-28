# Audit — domain-modeling (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** The ACTIVE glossary/ADR discipline (reading CONTEXT.md is a habit, changing the model is this skill): challenge terms against the glossary, sharpen fuzzy language, stress-test with invented edge scenarios, cross-reference claims against code, update CONTEXT.md INLINE as terms resolve (glossary ONLY — no implementation details), offer ADRs sparingly (all three: hard-to-reverse + surprising-without-context + real trade-off). Lazy file creation. Single vs multi-context layouts (CONTEXT-MAP.md). Formats: CONTEXT-FORMAT.md, ADR-FORMAT.md. Model-invoked.
**Deps:** setup's domain.md defines the consumer rules others follow; grill-with-docs/wayfinder/triage/improve-codebase-architecture invoke it.
**Security:** clean.
**Gaps/notes:** (1) The three-condition ADR test is worth adopting verbatim in OUR decisions-log discipline (06-decisions-log). (2) codebase-memory-mcp must respect docs/adr/ (re-confirmed).
**Audit outcome:** clean; no complement material; one house-rule import (ADR test → decisions log).
