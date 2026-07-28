# Project Setup Template

*Used by the project-setup skill; applies the Skill-vs-Project-vs-Hybrid framework.*

## 1. Classification (answer first)

| Signal | → Skill | → Project |
|---|---|---|
| Method/procedure | ✅ | |
| My accumulating data/context | | ✅ |
| Needed spontaneously anywhere | ✅ | |
| Needs long-running memory & chat history | | ✅ |
| Mostly static once written | ✅ | |
| Grows with new documents | | ✅ |

Hybrid = skill (method) + project (context) + Drive (sources) — the three-layer pattern.

## 2. Project instructions (draft skeleton)

> This project is my <domain> workspace. Claude should:
> - Treat <key doc> as authoritative for <what>.
> - For depth on <domain> topics, fetch `Skill-Library/<folder>/_summaries/<slug>.md` from Drive by filename; full book only if the summary points deeper.
> - <domain-specific behaviors, tone, constraints>

## 3. Knowledge docs to create

- `00-charter.md` — the instructions above
- `01-sources.md` — bibliography (`_sources.md` style: Owned ✅ / Wishlist 🛒 / Free 🔗)
- `02-notes.md` — accumulating personal notes/decisions
- <domain-specific docs>

## 4. Wiring checklist

- [ ] Drive folder exists (or points at an existing Skill-Library folder — no duplicates)
- [ ] Summaries present for owned books
- [ ] Related skills noted (which auto-fire here, which to call manually)
- [ ] First real question tested end-to-end (fetch cascade works)
