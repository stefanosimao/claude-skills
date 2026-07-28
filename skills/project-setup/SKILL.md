---
name: project-setup
description: "Stand up a new Claude project properly. Use when the user wants to create, set up, or structure a Claude project or workspace for a domain (e.g. 'set up a project for X', 'should this be a project or a skill?'). Applies the Skill-vs-Project-vs-Hybrid framework, drafts project instructions, proposes the knowledge-doc set, and wires the Drive library where books are involved. Do NOT use for setting up code repositories — that's setup-matt-pocock-skills territory."
---

# Project Setup

Stands up a new Claude project the right way: classification first, then scaffolding. Never scaffold before classifying — an empty pantry is pointless, and a method mislabeled as a project never triggers where it's needed.

## 1. Classify (the framework)

A **Skill** is a recipe card — portable method, activates in any kitchen. A **Project** is a pantry — your specific, accumulating context, lives in one kitchen. **Drive** is the cellar — bulk source material fetched only when needed.

| Signal | → Skill | → Project |
|---|---|---|
| Content is a method/procedure | ✅ | |
| Content is my data/context that accumulates | | ✅ |
| Needed spontaneously in any conversation | ✅ | |
| Needs long-running memory & related chat history | | ✅ |
| Mostly static once written | ✅ | |
| Grows continuously with new documents | | ✅ |

**Hybrid** = skill (method) + project (context) + Drive (sources) — the three-layer pattern. **Verdict rule:** state the classification and the one or two signals that decided it; if genuinely mixed, propose the hybrid and say which layer owns what. If the verdict is "skill," stop here and hand over to skill-forge.

**Timing rule:** create a domain project only when personal notes and context will actually start accumulating; until then the skill + Drive layers suffice.

## 2. Interview (only what classification didn't settle)

One question at a time, recommended answer first: What's the domain and the first real task? Which Skill-Library folder(s) ground it (existing — don't invent folders)? Which skills should fire here (auto) vs be called (manual)? What accumulates (notes, decisions, drafts)?

## 3. Scaffold

Draft, then let the user edit before anything is final:

1. **Project instructions** — from `references/instructions-template.md`: what Claude treats as authoritative, the fetch cascade for depth (search Drive by filename/slug — folder browsing doesn't work; verify freshness by content, never modifiedTime), domain behaviors and tone.
2. **Knowledge docs** — propose the minimal set: `00-charter.md` (the instructions), `01-sources.md` (`_sources.md`-style bibliography: Owned ✅ / Wishlist 🛒 / Free 🔗), `02-notes.md` (the accumulating layer), plus domain-specific docs only when the first task demands them.
3. **Drive wiring** — point at the existing `Skill-Library/<folder>/`; a project never duplicates a library folder (the SWE project points at software-engineering/, it doesn't copy it). Books never go INTO project knowledge: capacity limits, poor full-textbook retrieval, copyright.
4. **End-to-end test** — completion criterion for this whole skill: one real question answered in the new project with the fetch cascade exercised (skill/instructions → summary fetched → answer grounded). Not scaffolded-and-hoped: tested.

## References

- `references/instructions-template.md` — the project-instructions skeleton and wiring checklist.
