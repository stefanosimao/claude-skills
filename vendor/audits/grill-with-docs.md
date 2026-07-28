# Audit — grill-with-docs
*Read-understand-gap @ ed37663 · 7 lines · 2026-07-28*

**What:** Alias: user-invoked; body = "Run a /grilling session, using the /domain-modeling skill" — i.e. grilling that captures glossary terms and ADRs as decisions land.
**Dependencies:** grilling + domain-modeling (both hard). CONTEXT.md/docs/adr conventions from setup's domain.md.
**Hierarchy note:** an orchestrator invoking two disciplines — exactly the allowed direction of the hierarchy rule.
**Security:** clean. **Gaps:** none. Internal overlap of the grilling trio resolved: grill-me = plain alias, grill-with-docs = alias + docs side-effects, grilling = the engine. No trigger competition (only grilling is model-invoked).
**Audit outcome:** clean; no complement material.
