Gap Analysis — Matt's /code-review → extra-code-review scope

Read-understand-gap pass per Workflow C / Decision 23. Audited version: mattpocock/skills @ ed37663 (2026-07-21), skills/engineering/code-review/SKILL.md (89 lines). His skill stays VERBATIM; everything below defines the complement.

1. What his /code-review does

Two-axis review of git diff <fixed-point>...HEAD, both axes as parallel sub-agents, reports kept separate (never merged/reranked):

Standards axis — repo-documented standards (CODING_STANDARDS.md etc.) + a fixed baseline of 12 Fowler smells (Refactoring ch.3: Mysterious Name, Duplicated Code, Feature Envy, Data Clumps, Primitive Obsession, Repeated Switches, Shotgun Surgery, Divergent Change, Speculative Generality, Message Chains, Middle Man, Refused Bequest). Repo standards override the baseline; smells are always judgment calls; skip anything tooling enforces.
Spec axis — diff vs the originating issue/PRD: missing/partial requirements, scope creep, implemented-but-wrong. Needs the tracker infra from /setup-matt-pocock-skills.

Process discipline worth copying: pin & verify the fixed point before spawning agents; three-dot diff against merge-base; one message, parallel Agent calls; each report <400 words; findings cite the source (standard file / spec line); no cross-axis winner.

2. What it deliberately doesn't do (checked against his other skills too)

Verified across the engineering folder: no skill of his covers security at all (the only "inject" hit repo-wide is injecting sleeps in diagnosing-bugs). Performance and design depth live in the codebase-design trio — but those are codebase-wide skills, not per-diff review. So the genuine per-diff gaps:

Gap	What's missing on a diff review
Security	Injection, authz/authn on new endpoints, secrets in code/config, input validation at trust boundaries, crypto misuse, SSRF, unsafe deserialization, new-dependency risk
Defects	Bugs independent of the spec: unhandled error paths, edge cases (empty/null/overflow/encoding), concurrency & races, resource leaks, off-by-ones — his Spec axis catches "wrong vs spec", not "correct vs spec but broken"
Performance	N+1 queries, algorithmic complexity on hot paths, memory growth, missing pagination/streaming on data-touching changes
Tests	Whether the diff arrives with adequate tests: coverage of the changed behavior, test smells (over-mocking, testing implementation), missing regression test for a bug fix. His tdd skill governs writing, nothing reviews test quality on a diff
3. extra-code-review — proposed shape

Same skeleton as his, so the two run naturally side by side: same pinned fixed point, parallel sub-agents (one per axis), judgment-call labeling, repo-standards override, skip-what-tooling-enforces, <400 words per axis, no cross-axis reranking. Manual invocation, run alongside /code-review, never instead.

Four axes = the four gaps, each grounded in the canon (chapter-level citations come from the summaries):

Security — Anderson (Security Engineering), Stuttard & Pinto (WAHH), Ball (Hacking APIs). Baseline checklist distilled per trust-boundary type (web endpoint / API / data layer / config).
Defects — McConnell (Code Complete: defensive programming, error handling), Hunt & Thomas (Pragmatic Programmer: assertions, resource balance), Feathers for changes touching untested legacy code (seam quality, characterization tests first).
Performance — Kleppmann (DDIA) for data-touching diffs, Bentley (Programming Pearls) for back-of-envelope estimates the diff should survive.
Tests — SWE at Google (testing chapters: test sizes, flakiness, coverage philosophy), Percival & Molina for Python-specific test smells.

Overlap guards (what extra-code-review must NOT do): no Fowler smells (his baseline owns them); no spec conformance (his Spec axis); no codebase-wide architecture verdicts (his codebase-design trio); no bug diagnosis (his diagnosing-bugs — we flag suspects, we don't chase them).

4. Folder implications (Skill-Library/extra-code-review/)
Confirmed staying: Security Engineering, WAHH, Hacking APIs — the security axis rests on them; the pre-analysis guess was right.
Already arriving as copies: Refactoring, Working Effectively with Legacy Code (from software-engineering, dedupe rule). Refactoring now serves as reference for his baseline, not new material.
Add as summary-copies when wave 6 lands (per the dedupe rule — summaries copied, books stay in software-engineering): Code Complete, The Pragmatic Programmer, DDIA, Programming Pearls, SWE at Google, TDD with Python, Crafting TDD Software.
No new purchases required. Wishlist candidate only if the tests axis feels thin in practice: Unit Testing Principles (Khorikov).
5. Open until build time
Axis count vs budget: 4 parallel sub-agents per run is heavier than his 2 — fine for a manual repo-scoped skill, but confirm during Phase 1 testing.
Language flavor: his skill is TS-leaning; ours should stay language-neutral with per-language reference sheets only if testing shows the need.
Re-audit trigger: any upstream change to his code-review (version bump beyond ed37663) reruns this gap pass.
