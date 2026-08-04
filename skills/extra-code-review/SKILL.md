---
name: extra-code-review
description: "The four review axes Matt's /code-review doesn't cover — security, defects, performance, tests — on the same diff. Run alongside /code-review, never instead. Invoke by name."
---

# Extra Code Review

The complement to `/code-review` (vendored verbatim): four axes his two don't cover, on the same skeleton so the two reviews run naturally side by side. Built from the gap analysis (`vendor/audits/audit-code-review-gap-analysis.md`).

## Shared skeleton (identical to his, deliberately)

- **Pin the fixed point first** and verify it: review `git diff <fixed-point>...HEAD` (three-dot, against merge-base). Confirm the fixed point with the user before spawning anything.
- **One message, parallel sub-agents** — one per axis below. Reports kept SEPARATE: no cross-axis merging or reranking, no overall winner.
- Each report **<400 words**, findings cite their source (canon chapter or trust-boundary rule), every finding labeled a judgment call unless it's a demonstrable defect.
- **Repo standards override** the baselines below; **skip anything tooling already enforces** (linters, type checkers, SAST in CI).

## The four axes

**1. Security** — per trust boundary the diff touches (web endpoint / API / data layer / config): injection (SQL/command/template), authn/authz on new or changed endpoints, input validation at the boundary, secrets in code or config, crypto misuse (home-rolled, weak modes, bad randomness), SSRF, unsafe deserialization, path traversal, new-dependency risk (what does it pull in, who maintains it). Grounding: Anderson (*Security Engineering*), Stuttard & Pinto (*WAHH*), Ball (*Hacking APIs*) — cite chapter via the summaries.

> **Prose is executable — scope it in.** When the diff touches a skill, agent, prompt, or runbook, the `SKILL.md`/instruction text is **in scope for this axis, not documentation**: it tells a model how to build commands and requests, so an injection hole can live entirely in the prose while every script is clean. Reviewing only `scripts/` reviews half the artefact. Check quoting in any documented invocation template (double quotes do not stop `$(...)` or backticks — prefer stdin via a single-quoted heredoc), and treat model/tool output that re-enters context as untrusted input. Earned 2026-08-04: the worst finding in the `yt-gemini` review was in Step 2's command template, and source-only review would have passed it.

**2. Defects** — bugs independent of the spec ("correct vs spec but broken"): unhandled error paths, edge cases (empty/null/zero/overflow/encoding/timezone), concurrency and races on shared state, resource leaks (unclosed handles, unbounded growth, missing finally/defer), off-by-ones, assertion and invariant gaps. For diffs touching untested legacy code: seam quality, characterization-tests-first (Feathers). Grounding: McConnell (defensive programming, error handling), Hunt & Thomas (assertions, resource balance). **Flag suspects; never chase them** — diagnosis belongs to `/diagnosing-bugs`.

**3. Performance** — only where the diff touches data or hot paths: N+1 queries, algorithmic complexity on hot paths, unbounded memory growth, missing pagination/streaming on data-returning changes, chatty I/O in loops. Every flag passes a back-of-envelope test first (Bentley) — no micro-optimization theater. Grounding: Kleppmann for data-touching changes (systems/IO), Skiena for compute-side complexity and container choice (state it in dominance-order terms, not vibes).

**4. Tests** — does the diff ARRIVE with adequate tests: changed behavior covered at the right seam, regression test present when the diff fixes a bug, test smells (over-mocking, testing implementation not behavior, tautological assertions), test size/flakiness risk (*SWE at Google*), Python-specific smells (Percival, Molina). Grounding for the judgement calls: **Khorikov** — score a test on the four pillars, and apply the managed/unmanaged rule to decide whether a mock belongs; **Beck** for why a test exists at all. Note Beck's own concession that **security and concurrency cannot be driven by tests alone** — do not imply otherwise. Reviews the diff's tests; **never re-teaches the TDD loop** — that's `/tdd`.

## Overlap guards (hard boundaries)

No Fowler smells (his Standards axis owns them). No spec conformance (his Spec axis). No codebase-wide architecture verdicts (`/improve-codebase-architecture`). No bug diagnosis (`/diagnosing-bugs`). No re-teaching expand-contract (`/to-tickets` owns it).

## Fetch cascade

Drive: `Skill-Library/extra-code-review/` — owned: `security-engineering`, `the-web-application-hackers-handbook`, `hacking-apis`, `unit-testing-principles-practices-and-patterns`, plus dedupe copies `refactoring`, `working-effectively-with-legacy-code`; Referenced 📎 (summary local, book in software-engineering/): `code-complete`, `the-pragmatic-programmer`, `designing-data-intensive-applications`, `the-algorithm-design-manual`, `programming-pearls`, `software-engineering-at-google`, `test-driven-development-by-example`, `test-driven-development-with-python`, `crafting-test-driven-software-with-python`. Cite chapters from these maps.

## Open items (from the gap analysis, verify in Phase-1 testing)

4 parallel sub-agents is heavier than his 2 — acceptable for a manual repo-scoped skill; confirm. Stay language-neutral; add per-language sheets only if testing shows need. Any upstream change to his /code-review past `ed37663` reruns the gap analysis.
