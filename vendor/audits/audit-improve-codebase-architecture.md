# Audit — improve-codebase-architecture (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Codebase-wide deepening scan: scope by recent-change hot spots (git log) or user direction (YAGNI weighting); Explore-subagent walk noting friction (shallow modules, bounce-between-files, extracted-pure-functions-without-locality, untestable areas); deletion test applied; output = self-contained HTML report in OS temp dir (Tailwind+Mermaid CDN, before/after diagrams, Strong/Worth-exploring/Speculative badges, top recommendation); then user picks → /grilling loop with /domain-modeling side effects (terms, ADR offers on load-bearing rejections). ADR-conflict cards only when friction warrants reopening. `disable-model-invocation: true`.
**Deps:** codebase-design (vocabulary — mandatory), grilling, domain-modeling, CONTEXT.md/ADRs, Explore subagent type, HTML-REPORT.md.
**Security:** clean — report to temp dir, nothing lands in repo.
**Gaps/notes:** CDN dependency means the report needs network to render — fine on laptops, note for offline. Codebase-WIDE scope confirmed (vs per-diff): the boundary that defines extra-code-review's "no architecture verdicts" guard.
**Audit outcome:** clean; no complement material.
