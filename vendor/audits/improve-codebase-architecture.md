# Audit — improve-codebase-architecture
*Read-understand-gap @ ed37663 · 71 lines + HTML-REPORT.md (skimmed) · 2026-07-28*

**What:** User-invoked scan→report→grill orchestrator. Explore scoped by YAGNI (git-log hot spots unless the user names a direction), via Explore subagents, hunting SHALLOWNESS with the deletion test; presents candidates as a self-contained HTML report in the OS temp dir (Tailwind+Mermaid CDN, before/after diagrams, Strong/Worth-exploring/Speculative badges, top recommendation); then a /grilling loop on the picked candidate with /domain-modeling side-effects inline (glossary terms, rejection-ADRs offered only when load-bearing).
**Dependencies:** codebase-design (vocabulary, hard), domain-modeling, grilling, Explore subagent capability; CONTEXT.md/ADRs.
**Security:** clean — report deliberately outside the repo; CDN loads are in a local report file (fine).
**Gaps:** codebase-WIDE by design; the per-DIFF depth question stays with code-review/extra-code-review — boundary already respected in our gap analysis.
**Audit outcome:** clean; no complement material.
