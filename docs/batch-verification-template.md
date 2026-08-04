# Batch Verification — template

**Generic verification pass for any summarization batch.** `add-new-book` covers singles; this covers a wave. Fill in the wave-specific parts marked ⟨…⟩ and delete this line.

**Feed this to Claude Code** from inside `reMarkable/Skill-Library/`, in a FRESH session — **the auditor must not be the session that wrote the summaries.** Verify only — fix nothing without reporting it first.

Verify the batch against `summaries-task-v2.md` and produce the report described at the end.

## 1. Coverage — every book accounted for

For each folder in scope ⟨list folders, including any under `_projects/`⟩, diff the actual book files on disk against that folder's `_sources.md` entries, then confirm every book resolves to exactly one state:

- summarized → `_summaries/<slug>.md` exists
- skipped → marked `summary: skipped (<reason>)` in `_sources.md`
- duplicate → marked `[also in: X]` AND the summary .md file is COPIED into this folder's `_summaries/` (pointer notes don't count — the file must be physically present in both folders)

Flag: books in no state, summaries with no matching book (orphans), and any book on disk missing from `_sources.md` entirely.

⟨**Reconciliation note:** record here any decision that CHANGED mid-batch — un-skips, re-skips, scope changes. States must reflect the FINAL decision, not the original task text. Delete this block if nothing changed.⟩

## 2. Counters and metadata

- Recompute each `_sources.md` counter (`Summaries written: N/<non-skipped> · M skipped`) from the actual files; flag mismatches.
- Any OCR'd scans: `.ocr.pdf` present and noted in `_sources.md`.
- Slugs are kebab-case canonical English titles; each summary's `File:` field names a file that actually exists in that folder.
- **Paths are DESCRIPTIVE NAMES, never relative — checked across the WHOLE TREE, not just this wave.** `reMarkable/CS/AI/`, `Skill-Library/reasoning-mental-models/`, never `../../CS/AI/`. These are citations for a reader; nothing dereferences them, and Drive has no sibling tree to resolve them against.

  ```bash
  grep -rn '\.\./' Skill-Library/ --include='*.md' \
       --exclude='batch-verification-template.md'   # must return zero hits
  ```

  (The exclusion is this file itself — it quotes the anti-pattern above, so without it the check can never pass.)

  This is a **tree invariant, not a wave check** — scoping it to new files misses loose READMEs, folder relocations, and anything added between waves. The `_projects/` relocation broke 16 refs in one file, and a stray `../software-engineering/` in `_projects/software-engineering-README.md` survived the library-wide sweep precisely because that file was neither a summary nor a `_sources.md`. Whole-tree costs nothing extra; scoping it is what lets violations back in.

## 3. Template conformance (structural pass over ALL summaries)

Every summary has all six sections: Core thesis · book-in-one-paragraph · Chapter map (or equivalent structural map) · Key frameworks & models · Distillation pointers · Depth pointers. Length ~4–6 pages (8 max). Translated editions keep original chapter names alongside.

Flag any summary drastically shorter than its book's weight class suggests — a 600-page book with a one-page map is a failure even if all six sections exist.

## 4. Quality sampling (the spot-check, applied seriously)

Sample 6 summaries: 2 from the first wave, then one from each remaining completed wave — at least one Sonnet-tier, at least one from an OCR'd scan if the batch had any, at least one non-English edition if the batch had any, and none of the pilot/reference books.

For each sampled summary:

a. **Map test:** pose 3 "which chapter/section covers X?" questions for concepts you can verify are in the book (open the book to confirm if unsure). The map alone must answer all 3.
b. **Handle test:** pick 3 named frameworks from Key Frameworks; confirm each has a one-line definition and a chapter/section pointer.
c. **Verbatim test:** scan for transcribed blocks (checklists, question lists, scripts copied rather than paraphrased into method). Named trigger phrases are fine; block reproduction is a violation.
d. **Contamination test:** confirm each sampled summary discusses only its own book. Check for markers belonging to another book in the same wave — parallel subagents sharing a scratchpad have silently overwritten each other's extracted text before, and a summary of the wrong book has no visible symptom.

**Escalation rule:** if a Sonnet-tier sample fails the map test, extend sampling to 2 more Sonnet-tier summaries before concluding — one bad summary is noise, three is a tier problem.

## 5. Report

Write `_batch-verification-⟨YYYY-MM-DD⟩.md` in the Skill-Library root:

- Per-folder table: books / summarized / skipped / duplicates-copied / counter-correct (✓/✗)
- Findings list, each tagged **BLOCKER** (missing/failed summaries, failed map tests, verbatim violations, contamination) or **COSMETIC** (slug style, counter drift, metadata gaps)
- Sampling results per test (4a/4b/4c/4d), naming which summaries were sampled and their model tier
- Verdict: **READY FOR DRIVE UPLOAD** or **FIX FIRST**, with the fix list ordered by effort

Propose fixes for everything found; apply them only after I confirm. Do not re-summarize any book without asking.

**Retire the report once its findings are closed** — the durable record is the catalog build log. Dated reports are wave artifacts, not library documents.
