# Add a New Book to the Skill-Library — v2

**Feed this to Claude Code** from inside `Skill-Library/`, together with the path to the new book file:

> Add this book to the Skill-Library per add-new-book-v2.md: `<path/to/file>`

Works for one book or several. Rules and template references point to `summaries-task-v2.md` — read it first.

**v2 changes:** EPUB-only titles in claude.ai-enabled folders get a PDF access copy at intake (the Drive connector can't read EPUB content); Drive-freshness warning added (never trust `modifiedTime`). Upload remains MANUAL — the local tree does not auto-sync.

---

## Step 1 — Identify

Open the file and establish: title, author, year, edition/language, page count. If the file has no usable metadata (EOC_1.pdf-style), read a few pages and report what it appears to be — ASK before proceeding if identification is uncertain.

## Step 2 — Choose the folder(s)

Propose the destination folder and WAIT for my confirmation before copying. Rules:
- One folder per skill; the book goes where its distillation belongs, not everywhere it rhymes (shared *dependencies* get duplicated, shared *vibes* don't).
- If it genuinely feeds two skills, copy to both and mark `[also in: X]` in each `_sources.md`.
- If it fits no existing folder, say so — it may belong to a project bibliography (`_projects/`) or nowhere; don't invent a folder.
- Check the target folder's `_sources.md` Wishlist: if this book is on it, this is a wishlist fulfillment — note it.
## Step 3 — File hygiene

- Prefer PDF over EPUB if both were provided; note format in `_sources.md`.
- EPUB-only + the folder is claude.ai-enabled (see catalog enabled-where): also produce a PDF access copy (Calibre or equivalent), stored alongside. Note it: `(PDF conversion added for claude.ai readability)`. The EPUB stays canonical.
- Check for a text layer (`pdffonts`). Image-only scan → run `ocrmypdf`, write `<name>.ocr.pdf` alongside, note it. Visual reading is fallback only.
- Filename stays as-is; the `File:` field in the summary records it.
## Step 4 — Update `_sources.md`

- Add the book under **Owned ✅** with filename and format (move it out of Wishlist 🛒 if it was there).
- Decide: does it get a summary, or is it skip-list material? Skip only works that already ARE summaries/references (poster sets, phrase lists, anthologies, visual references — see the skip list in summaries-task-v2.md; when in doubt, summarize: the Dunlosky reversal showed a rigorous primary source is payload even at 55 pages). Mark skips as `summary: skipped (<reason>)`.
- Update the counter (`Summaries written: N/<non-skipped> · M skipped (reason)`).
## Step 5 — Summarize

If not skipped: spawn ONE fresh subagent to read the whole book and write `<folder>/_summaries/<slug>.md` per the template in summaries-task-v2.md (slug = kebab-case canonical English title). Read one existing approved summary first (e.g. `negotiation-persuasion/_summaries/never-split-the-difference.md`) as the exemplar. For `[also in: X]` duplicates: summarize once, copy the .md to the other folder. Then the orchestrator increments the counter(s).

## Step 6 — Report

Print: folder(s) chosen and why · wishlist fulfilled? · OCR / PDF-conversion applied? · summary written or skip reason · updated counter line(s) · **the exact list of files created/modified — this list is my upload checklist.**

---

## MANUAL — Drive upload (me, after the run)

Local and Drive must stay in sync; I am the sync:

1. Open Google Drive → `Skill-Library/<same-folder>/`.
2. Upload the book file (plus the `.ocr.pdf` and/or conversion `.pdf` if made).
3. Upload the new `_summaries/<slug>.md` into that folder's `_summaries/`.
4. Re-upload the updated `_sources.md` replacing the old one (right-click → Manage versions → Upload new version — keeps the same file ID).
5. If the book went to two folders: repeat for the second (book copy + summary copy + its `_sources.md`).
6. Sanity check in claude.ai: search Drive for the book's filename AND the summary slug. Allow a few minutes' indexing lag; folder browsing doesn't work, filename search does.
7. ⚠️ Never judge Drive freshness by `modifiedTime` — it's stale index metadata. Verify by content, not timestamps.
If the book fulfilled a wishlist entry, the catalog's wishlist aggregate is updated in **`catalog.md` in the claude-skills repo** — the single authoritative copy (Decision 34) — and the Hub mirror is re-exported from it per [`mirror-export.md`](mirror-export.md). *(Corrected 2026-08-04: this said the update happens "in the Skills Hub project", which was true while the Hub held the master catalog and is now backwards — the Hub holds a derived copy.)*
