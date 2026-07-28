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
| extra-code-review | 1.0 | 🧪 draft-built | manual | 4 axes per gap analysis; same skeleton as his |

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

Thinking in Systems (Meadows — confirmed gap, evidence banked) · Superforecasting (Tetlock) · Illustrated Book of Bad Arguments (Almossawi) · Being Logical (McInerny) · Peopleware (DeMarco & Lister) · Unit Testing Principles (Khorikov — only if tests axis feels thin)

## Context audit ledger

Baseline (Laptop A, 2026-07-28, CC 2.1.218, Opus 4.8 1M): system 24.7k · built-in skills 15 = 2k · MCP 74 tools = 0 at rest · **total 26.8k (3%)**. No user skills, no CLAUDE.md, no hooks. Block list at baseline: empty.
Next measurement: after first bulk sync.

## Build log
- 2026-07-28: Phase 0 closed (repo live, Drive fetch-tested, baseline audit). Vendor commit + 22/22 audits. All 13 original skills draft-built by Claude (Skills Hub session); status 🧪 = built, NOT yet tested/installed — next: cross-session review against project docs, then Workflow A steps 3–6 per skill (test → iterate → package → deploy), autos first (trigger testing in Claude Code).
