# Skill-Library Summarization Task — v2 (post-pilot)

**Feed this file to Claude Code** from inside `reMarkable/Skill-Library/`. It writes the `_summaries/<book>.md` maps that complete the fetch cascade: **skill distillation → book summary (~5 pages) → full book**. Most depth queries must resolve at the summary level — that's the quality bar.

**v2 changes (pilot reviewed & approved):** pilot complete (Kahneman, Pólya, Voss ✅ — template validated); verbatim-reproduction exception deleted (rule 1 below); "equivalent structural map" sanctioned for non-chapter books (rule 2); OCR pre-step added for image-only scans; pandoc note dropped (pure-Python EPUB extraction validated); Dunlosky loose end resolved (recovered and filed).

---

## How to run

1. **One book per subagent.** Spawn a fresh Task subagent per book (or `/clear` between books if running sequentially). Never carry one book's context into the next — quality degrades in long contexts.
2. **The subagent reads the whole book**, in chunks if large, then writes exactly one file: `<folder>/_summaries/<book-slug>.md` using the template below.
3. **EPUB-only titles:** extract text directly (pure-Python extraction validated in the pilot; pandoc not required).
4. **After each book:** the ORCHESTRATOR (never the subagent) increments the counter in that folder's `_sources.md` (`Summaries written: N/<total>`). Subagents report back; one writer for shared state.
5. **Work folder-by-folder in the priority order** below. Stop and report after each folder completes.
6. **Slug convention:** kebab-case of the canonical English title, shortened to the distinctive part (`thinking-fast-and-slow.md`, `how-to-solve-it.md`) — even for Italian editions. The `File:` field inside records the real filename on disk.

## OCR pre-step (before each wave)

Some PDFs are image-only scans with no text layer — reading them visually is an order of magnitude more expensive (the Pólya pilot cost 142 tool calls improvising with ghostscript). Before starting a wave:

1. Check each of the wave's PDFs for a text layer (`pdffonts file.pdf` — empty output = scan).
2. Run `ocrmypdf` on any scan (install if missing: `pip install ocrmypdf` + system tesseract). Write the OCR'd copy alongside, e.g. `<name>.ocr.pdf`; the subagent reads that.
3. Note in `_sources.md`: `(OCR layer added — read <name>.ocr.pdf)`.
4. Visual page-by-page reading is the FALLBACK only, for scans where OCR quality is too poor (spot-check a few pages).

Known scans from the build: How to Win Every Argument (Pirie — wave 2, next to hit this), Programming Pearls (both copies, wave 6), Quantum Physics (Gribbin, wave 7). Pólya is already summarized; What If? is skipped anyway.

---

## PILOT — ✅ complete and approved

Kahneman (reasoning-mental-models), Pólya (problem-solving), Voss (negotiation-persuasion) are written, reviewed, and approved as the quality reference. **Before batching, read one of them** (e.g. `negotiation-persuasion/_summaries/never-split-the-difference.md`) as the exemplar. Batch resumes at wave 1, skipping any book whose summary file already exists.

---

## Summary template (`_summaries/<book-slug>.md`)

```markdown
# <Title> — <Author> (<year>)

**File:** `<filename-on-disk>` · **Folder:** <skill-library-folder> · **Length:** <pages> pp

## Core thesis
2–4 sentences: the one idea the book exists to defend.

## The book in one paragraph
What it argues, how it's structured, what kind of book it is (research synthesis / method manual / essay collection).

## Chapter map — or an equivalent structural map
| # | Chapter | Topics | Key concepts & frameworks |
|---|---------|--------|---------------------------|
| 1 | <name> | <what it covers> | <named models, methods, terms — the searchable handles> |

(For part-structured books, group rows under part headings. For books whose real organization is not chapters — dictionaries, article collections, toolkits — build the structural map that mirrors the book's ACTUAL organization instead of forcing a chapter table. The invariant is unchanged either way: the spot-check "which section covers X?" must resolve from the map alone.)

## Key frameworks & models
Bulleted list of every NAMED, reusable framework/method/heuristic with a one-line definition and the chapter/section where it lives. This section powers the distillation pass — err toward complete.

## Distillation pointers
3–6 bullets: which chapters carry the skill-worthy material, what's filler, what overlaps with other books in this folder (name them). Include reliability caveats where known (e.g. failed replications).

## Depth pointers
When would someone need the full book instead of this summary? Which chapters for which question?
```

Rules:
- **Own words throughout — no long quotes, no verbatim reproduction.** Procedural content (checklists, question lists, scripts, exercises) is PARAPHRASED into executable form, never transcribed. Exact wording is permitted only for short named phrases that function as searchable handles (a technique's trigger phrase, a named question). If you find yourself copying a block, stop and rewrite it as method.
- ~4–6 pages target (dense books may hit 8, never more).
- Concepts must be *named* so they're searchable handles for the fetch cascade.
- Summaries in English; for translated editions keep original part/chapter names alongside.

---

## Priority order (= Phase 3 build order)

| Wave | Folders | Note |
|------|---------|------|
| 1 | reasoning-mental-models, decision-making, problem-solving | feed reasoning-toolkit, first build |
| 2 | critical-thinking-logic | argument-analysis; OCR Pirie first |
| 3 | negotiation-persuasion | |
| 4 | meta-learning | study |
| 5 | economics, politics-geopolitics | society-lenses |
| 6 | software-engineering, extra-code-review | on-demand grounding; dedupe: a book summarized in one folder gets its summary FILE COPIED to the other folder's _summaries/ (`[also in: X]` titles), not re-read |
| 7 | quantum-computing, _projects/good-father | no skill deadline; run last or on demand |

## SKIP list — do not summarize

Works that already ARE summaries/references (a map of a map is noise):
- All-B&W-Posters (Learning Scientists) · The Decision Book (Krogerus & Tschäppeler) · Bjork & Bjork 2020 paper · Dunlosky et al. 2013 paper · What If (Munroe — anthology, no framework payload) · 97 Things Every Programmer Should Know (aphorism collection) · Exactly What to Say (phrase list) · Simply Quantum Physics (DK visual reference)

Mark these in `_sources.md` as `summary: skipped (reference work)` so the counters still reconcile.

## Duplicate titles (`[also in: X]`)

Summarize ONCE, in the first folder encountered; copy the finished .md into the other folder's `_summaries/`. Applies to: Art of Thinking in Systems, Programming Pearls, Refactoring, Working Effectively with Legacy Code.

---

## Verification (end of each wave)

- Every non-skipped book has a `_summaries/<slug>.md`
- `_sources.md` counters match reality
- Spot-check: pick one summary, ask "which chapter/section covers X?" for a concept you know is in the book — the map must answer it.
