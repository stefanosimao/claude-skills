# Skill Catalog

*Authoritative inventory. Mirror of the Skills Hub project catalog — this copy travels with the repo.*

**Legend** — Status: 💡 idea · 📋 backlog · ✏️ draft · 🧪 testing · ✅ installed · ⛔ removed · 📦 built-not-installed
**Invocation:** auto · auto(narrow) · manual
**Enabled:** CC = Claude Code (laptops) · ai = claude.ai account (covers cloud/Cowork/routines) · repo = repo-scoped only

## Installed

| Skill | Ver | Status | Invocation | CC | ai | repo | Notes |
|---|---|---|---|---|---|---|---|
| bonsai-care | 1.1 | ✅ | manual | ☐ | ☑ | ☐ | improvement queue: split refs, add bibliography, re-test triggers |

## Meta

| Skill | Ver | Status | Invocation | Notes |
|---|---|---|---|---|
| ask-tete | 1.0 | 🧪 draft-built | manual | concierge over full catalog (Matt flows + mine); built 2026-07-28, testing pending |
| skill-forge | 1.0 | 🧪 draft-built | manual | skill-creator loop + house rules + writing-great-skills principles; supersedes stock skill-creator (block it) |
| project-setup | 1.0 | 🧪 draft-built | auto(narrow) | Skill-vs-Project framework; first real test = good-father |

## Thinking & learning (book-distilled)

| Skill | Ver | Status | Invocation | Library folders |
|---|---|---|---|---|
| reasoning-toolkit | 1.0 | 🧪 draft-built | auto(narrow) | reasoning-mental-models + decision-making + problem-solving |
| argument-analysis | 1.0 | 🧪 draft-built | auto | critical-thinking-logic |
| negotiation-persuasion | 1.0 | 🧪 draft-built | auto | negotiation-persuasion |
| society-lenses | 1.0 | 🧪 draft-built | manual | economics + politics-geopolitics |
| study | 1.0 | 🧪 draft-built | manual | meta-learning (reads all folders); coexists with /teach verbatim |

## Programming — Layer 1: Matt verbatim (vendored, pinned @ ed37663, never edited)

grill-me · grill-with-docs · wayfinder · to-spec · to-tickets · triage · implement · handoff · improve-codebase-architecture · teach · setup-matt-pocock-skills · grilling · tdd · diagnosing-bugs · code-review · prototype · research · domain-modeling · codebase-design · resolving-merge-conflicts · git-guardrails · setup-pre-commit

Status: ✅ vendored @ ed37663, audited 22/22 (see vendor/audits/) · Scope: **repo-scoped / manual only** (never account-wide) · Updates only via deliberate re-audit + pin bump.
Excluded: ask-matt, writing-great-skills (reference only), scaffold-exercises, migrate-to-shoehorn, deprecated/in-progress/personal.

## Programming — Layer 2: my complements

| Skill | Ver | Status | Invocation | Notes |
|---|---|---|---|---|
| software-engineering | 1.0 | 🧪 draft-built | auto(narrow) + callable | canon consultant; defers to /codebase-design vocabulary in-pipeline |
| extra-code-review | 1.1 | 🧪 draft-built | manual | 4 axes per gap analysis; same skeleton as his · **1.1 (2026-07-28):** PERFORMANCE axis re-grounded three-way after Skiena landed — DDIA systems/IO, Skiena compute, Pearls estimation; SKILL.md §3 + `references/axes.md` PERFORMANCE block + Referenced 📎 list updated. Sources and skill body now agree; still pre-test |

## Personal

| Skill | Ver | Status | Invocation | Enabled |
|---|---|---|---|---|
| settimana-enigmistica | 1.0 | 🧪 draft-built | manual | claude.ai only; anagram verification script included (tested) |
| swiss-voting | 1.0 | 🧪 draft-built | manual | claude.ai only; live-web hybrid, no stored data |

## Removed / repurposed

| Item | Status | Notes |
|---|---|---|
| interview-answer-coach | ⛔ | full rebuild planned via skill-forge (fresh intent capture) |
| quantum-computing | 📦 | content → QC project knowledge; not installed as skill |


## Wishlist aggregate (from Skill-Library `_sources.md`)

Thinking in Systems (Meadows — confirmed gap, evidence banked) · TDD: By Example (Beck — confirmed gap: own the popularizations, not the primary source) · Superforecasting (Tetlock) · Illustrated Book of Bad Arguments (Almossawi) · Being Logical (McInerny) · Peopleware (DeMarco & Lister) · Unit Testing Principles (Khorikov — only if tests axis feels thin; re-evaluate if Beck lands first)

Acquisition priority: **Meadows → Beck**, then the rest. All checked against `../CS/` on 2026-07-28 — none of the above is there.

**Free pickups (already on disk under `../CS/`, no purchase):** ✅ The Algorithm Design Manual (Skiena) — copied into `software-engineering/` and summarized 2026-07-28; fills the algorithms/complexity axis nothing else in Skill-Library covered, and the extra-code-review PERFORMANCE axis (compute side). Before adding new Skill-Library books, check `../CS/` first — it holds ~120 CS/AI titles and overlaps this library substantially.

## `../CS/` cross-check ledger (2026-07-28)

Full sweep of all 148 files in `../CS/` against every Skill-Library folder. Verdicts:

**Pulled in:** Skiena (done, see build log).

**Recommended next pickups — free, still un-actioned:**
- **Operating Systems: Three Easy Pieces** (Arpaci-Dusseau) — `CS/TOP/`. **Confirmed gap: concurrency.** Grep of all summaries: no `mutex`, no `memory hierarchy`; `race condition` appears once (Clean Architecture, in passing). The only concurrency treatment owned is Clean Code Ch 13 (defensive principles for threaded code) and Pragmatic Programmer's deadlock-avoidance-by-lock-ordering. Nothing covers data races vs. race conditions, lock granularity, condition variables, semaphores, atomics, or memory models. OSTEP Part II is 9 chapters on exactly this, including a chapter on common concurrency bugs. **Fills the extra-code-review DEFECTS axis's largest hole — and note the axis is already asking for it:** `axes.md` DEFECTS has a Concurrency bullet (shared mutable state, TOCTOU, async ordering, deadlock lock-ordering), but the axis's named grounding is McConnell/Hunt & Thomas/Feathers, none of whom treats concurrency in depth. The checklist currently outruns its canon. Highest-value remaining free pickup.
- **Computer Systems: A Programmer's Perspective** (Bryant & O'Hallaron) — `CS/TOP/`. Memory hierarchy, cache-friendly code, program optimization. Would extend the PERFORMANCE axis below Skiena's altitude (constant factors, locality) where only Programming Pearls currently reaches. Second priority — take only if the axis proves thin.

**Assessed and deliberately NOT pulled in** (recording so this isn't re-litigated): Database Internals, Distributed Systems (van Steen/Tanenbaum), Readings in Database Systems — all subsumed by DDIA at the right altitude · Head First / Dive Into / Explained design-pattern books, Java Design Patterns — redundant with GoF · Dive Into Refactoring — redundant with Fowler · Patterns Principles & Practices of DDD — redundant with Evans · Becoming a Better Programmer, Coders at Work, Real-World Software Development, Think Like A Programmer — craft/aphorism/interview-anecdote, overlap Pragmatic + 97 Things + Apprenticeship Patterns · Crafting Interpreters, Dragon Book, SICP, nand2tetris, Code (Petzold), Inside the Machine, Understanding Computation — foundational or domain-specific, no skill consumes them · Kurose & Ross, TCP-IP Illustrated — networking, no skill consumes it · Classic CS Problems in Python, Competitive Programmer's Handbook, Essential Algorithms, 40 Algorithms, Grokking Algorithms — subsumed by Skiena · Hacking: The Art of Exploitation — memory-corruption/shellcode, only relevant if reviewing C/C++; SECURITY axis already rests on Anderson/WAHH/Ball · Kali Linux Revealed + the beginner-hacking titles — tooling/ops, no distillation value · all Cloud/AWS/Azure and the Python how-to shelf — vendor/tutorial, out of scope.

**Two openings flagged, no action taken (need your call):**
- **Interview prep.** `interview-answer-coach` is ⛔ pending a skill-forge rebuild. `CS/Algos/` holds Cracking the Coding Interview (PDF + EPUB), Elements of Programming Interviews (C++), and `CS/AI/` has The AI Engineer Interview Bible — plus Skiena §13.1 is now summarized. A source folder exists for free whenever that rebuild starts.
- **AI/LLM engineering.** `CS/AI/` has 28 titles including AI Engineering and Designing Machine Learning Systems (Huyen), Build a Large Language Model From Scratch (Raschka), LLM Engineer's Handbook, Deep Learning (Goodfellow). Skill-Library has **no** AI folder and the catalog has no AI skill — the largest uncovered subject area in the whole reMarkable library, and the one closest to the work this hub exists to support.

**Duplicate noted:** Essentials of Game Theory (Leyton-Brown & Shoham) exists in both `CS/Programming/` and `economics/` — already summarized in economics, no action.

## Context audit ledger

Baseline (Laptop A, 2026-07-28, CC 2.1.218, Opus 4.8 1M): system 24.7k · built-in skills 15 = 2k · MCP 74 tools = 0 at rest · **total 26.8k (3%)**. No user skills, no CLAUDE.md, no hooks. Block list at baseline: empty.
Next measurement: after first bulk sync.

## Build log
- 2026-07-28: **Skiena added.** `../CS/` cross-checked against every `_sources.md` wishlist. The Algorithm Design Manual (3rd ed.) copied `CS/TOP/` → `software-engineering/`, summarized (`_summaries/the-algorithm-design-manual.md`), dedupe copy filed in `extra-code-review/_summaries/` per the summaries-task rule. software-engineering now 21/21; extra-code-review Referenced 📎 now 8. PERFORMANCE axis split explicitly: DDIA = systems/IO, Skiena = compute, Pearls = estimation. Also confirmed the ⚠ SRE draft PDF is byte-identical in both libraries — no good local copy exists.
- 2026-07-28: Phase 0 closed (repo live, Drive fetch-tested, baseline audit). Vendor commit + 22/22 audits. All 13 original skills draft-built by Claude (Skills Hub session); status 🧪 = built, NOT yet tested/installed — next: cross-session review against project docs, then Workflow A steps 3–6 per skill (test → iterate → package → deploy), autos first (trigger testing in Claude Code).
