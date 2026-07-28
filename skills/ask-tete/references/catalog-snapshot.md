Snapshot of catalog.md @ 65b9379 — regenerate on catalog changes (skill-forge step 6). Stamp = catalog.md's last-touching commit at generation time, not HEAD; the shipping commit is necessarily one later.

Fallback listing only, for when the claude-skills repo is unreachable. Not the catalog: no build log, no wishlist, no ledgers. Status is 🧪 draft-built unless marked otherwise — tested and passing, not yet deployed everywhere.

# My skills

## Meta

| Skill | Invocation | Purpose | Enabled |
|---|---|---|---|
| ask-tete | manual | catalog concierge — which skill fits, and how to run it | CC + ai |
| skill-forge | manual (orchestrator) | build, improve, or import a skill; house conventions | CC + ai |
| project-setup | auto(narrow) | stand up a Claude project; Skill-vs-Project-vs-Hybrid framework | CC + ai |

## Thinking & learning (book-distilled)

| Skill | Invocation | Purpose | Enabled |
|---|---|---|---|
| reasoning-toolkit | auto(narrow) | decisions and stuck problems — mental models, inversion, base rates, pre-mortems | CC + ai |
| argument-analysis | auto | dissect an argument, name fallacies, debate prep; always steelmans | CC + ai |
| negotiation-persuasion | auto | negotiations, difficult conversations, high-stakes messages | CC + ai |
| society-lenses | manual | news/policy/events through ≥3 named lenses, schools kept competing | CC + ai |
| study | manual (orchestrator) | learning paths and retention from the Skill-Library canon | CC + ai |

## Programming — Layer 2 (my complements to the Matt set)

| Skill | Invocation | Purpose | Enabled |
|---|---|---|---|
| software-engineering | auto(narrow) + callable | canon consultant — design/architecture questions with chapter citations | CC + ai |
| extra-code-review | manual (orchestrator) | the 4 axes /code-review doesn't cover: security, defects, performance, tests | CC + ai |

## Personal

| Skill | Invocation | Purpose | Enabled |
|---|---|---|---|
| bonsai-care | manual | species-aware bonsai diagnosis, care, styling (✅ installed) | ai |
| settimana-enigmistica | manual | Italian puzzle solving; anagram verification script | ai |
| swiss-voting | manual | federal/cantonal votes, both committees neutrally; never advises a vote | ai |

# Matt vendor layer (22, verbatim @ ed37663)

**Repo-scoped only.** These commands exist ONLY where `vendor/mattpocock/` was copied whole into that repo's `.claude/skills/` and `/setup-matt-pocock-skills` has been run once there. Never account-wide.

| Phase | Skill | Invocation | Purpose |
|---|---|---|---|
| Setup | setup-matt-pocock-skills | user | install the set into a repo — run once, before any flow |
| Setup | setup-pre-commit | user | pre-commit hooks |
| Setup | git-guardrails | user | git safety rails |
| Sharpen | grill-me | user | interview an idea into shape — no codebase |
| Sharpen | grill-with-docs | user | same, with a codebase; leaves CONTEXT.md + ADRs |
| Sharpen | grilling | model | the interview discipline itself |
| Sharpen | research | model | investigate before deciding |
| Sharpen | prototype | model | runnable answer to a question; reached via handoff |
| Map | wayfinder | user | huge foggy effort — charts decisions, not deliverables |
| Map | to-spec | user | decisions → spec |
| Map | to-tickets | user | spec → tracer-bullet tickets with blocking edges |
| Map | triage | user | issues piling up (only ones you didn't create) |
| Build | implement | user | one ticket, fresh context; drives tdd, closes with code-review |
| Build | tdd | model | the red-green-refactor loop |
| Review | code-review | user | Fowler smells + spec conformance |
| Fix | diagnosing-bugs | model | something broken that resists a first glance |
| Fix | resolving-merge-conflicts | model | conflict resolution |
| Maintain | improve-codebase-architecture | user | spare-moment upkeep |
| Vocabulary | domain-modeling | model | domain terms |
| Vocabulary | codebase-design | model | module shape |
| Continuity | handoff | user | carry context into a fresh session |
| Teaching | teach | user | interactive multi-session course in a dedicated folder |

**Main flow:** grill-with-docs / grill-me → (handoff → prototype → handoff) → to-spec → to-tickets → implement per ticket → code-review → extra-code-review. Steps 1–3 stay in one window; each implement starts fresh.
