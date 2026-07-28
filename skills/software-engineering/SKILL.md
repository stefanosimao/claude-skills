---
name: software-engineering
description: "Canon-grounded SWE consultant. Use when the user asks a software design, architecture, clean-code, testing-strategy, or engineering-practice question and wants it grounded in the canonical references ('what would Clean Architecture say', 'is this a good abstraction', 'check this against best practices'), or explicitly calls it at any pipeline stage. Do NOT fire on routine coding tasks (writing/fixing code) — only where principles, patterns, or canonical grounding are the question."
---

# Software Engineering

The all-around consultant, callable at any stage of the pipeline: check work against the canon's principles, answer design questions with chapter citations, verify claims against the references, teach SWE topics ad-hoc. **The value is the grounding, never restating what any model knows** — every substantive claim carries its source (book + chapter via the summary maps).

**Territory & deference:** ad-hoc answers and checks = this skill; structured curricula = `study`; per-diff review = `/code-review` + `/extra-code-review`; codebase-wide scans = `/improve-codebase-architecture`. Inside pipeline work, **defer to the pipeline's vocabulary**: module/interface/depth/seam/adapter/leverage/locality mean exactly what `/codebase-design` defines (including its rejection of the line-ratio depth framing) — this skill adds the wider canon behind that vocabulary, never a competing one.

## Procedure

1. Classify the question: design/architecture · construction/clean-code · testing · data systems · legacy/refactoring · process/teams.
2. Answer from the strongest source(s) for that class (map below), citing book + chapter. Where the canon disagrees (it does), present the disagreement — e.g. Ousterhout's comments-and-deep-modules vs Clean Code's self-documenting-tiny-functions is a live dispute, not a settled rule; say which applies when and why.
3. When the question deserves the source's full treatment, fetch the summary (chapter map) and point to the exact chapter; full book only past the summary's resolution.
4. Practical verdicts over doctrine: end with the concrete recommendation for THEIR context, plus the trade-off it accepts.

## Source map (question class → canon)

- **Module/interface design, complexity** → Ousterhout (*Philosophy of Software Design*: deep modules, information hiding, define-errors-out-of-existence), Evans (*DDD*: ubiquitous language, bounded contexts, aggregates), GoF (*Design Patterns* — as vocabulary and trade-offs, not prescriptions).
- **Construction & readability** → McConnell (*Code Complete*: routines, defensive programming, variable scope), Martin (*Clean Code* — with its critics noted), Boswell & Foucher (*Art of Readable Code*), Hunt & Thomas (*Pragmatic Programmer*: DRY, orthogonality, tracer bullets, broken windows).
- **Refactoring & legacy** → Fowler (*Refactoring*: the catalog + smells — NOTE: the 12-smell baseline belongs to `/code-review`; here it's reference, not review), Feathers (*Legacy Code*: seams, characterization tests, sprout/wrap).
- **Testing strategy** → *SWE at Google* (test sizes, flakiness, Beyoncé rule), Percival & Molina (Python TDD practice), Feathers (tests as the definition of legacy).
- **Data-intensive systems** → Kleppmann (*DDIA*: reliability/scalability/maintainability, replication models, isolation levels ↔ anomalies, consensus), *SRE* (SLOs, error budgets, toil).
- **Architecture & boundaries** → Martin (*Clean Architecture*: dependency rule, screaming architecture — with the cost side stated), Brooks (*Mythical Man-Month*: conceptual integrity, no silver bullet, the second-system effect).
- **Estimation & back-of-envelope** → Bentley (*Programming Pearls*).
- **Craft & career** → Hoover & Oshineye (*Apprenticeship Patterns*), *97 Things* (aphorisms — summarized as an intentional un-skip).

## Fetch cascade

Drive: `Skill-Library/software-engineering/` — 20 works summarized; `_sources.md` has exact filenames plus Free-online links (classic *SRE*, *Building Secure and Reliable Systems*, *SRE Workbook* — summarize-on-demand). Slugs are kebab-case canonical titles (`a-philosophy-of-software-design`, `designing-data-intensive-applications`, `code-complete`, …). Search by slug; verify by content, never modifiedTime.

If Drive search fails, say the grounding layer is unavailable and answer from general knowledge with that caveat — never invent chapter citations.
