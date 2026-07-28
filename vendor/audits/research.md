# Audit — research
*Read-understand-gap @ ed37663 · 12 lines · 2026-07-28*

**What:** Spins up a background agent to investigate a question against PRIMARY sources (official docs, source code, specs), writes one cited markdown file into the repo following its existing note conventions.
**Invocation:** model-invoked. **Dependencies:** background-agent capability; soft: repo note conventions. Consumed by wayfinder (research tickets, fired in parallel on throwaway research/<name> branches).
**Security:** clean — writes only a repo md.
**Gaps/notes:** Overlaps native deep-research features for *general* questions; its distinct value is the OUTPUT LOCATION (a sprint-lifetime repo asset other skills can read) and the primary-source discipline. Keep both mental models: native research for me, /research for repo-cached facts.
**Audit outcome:** clean; no complement needed.
