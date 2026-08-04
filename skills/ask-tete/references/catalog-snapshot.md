Snapshot of catalog.md @ 8f9932e — regenerate on catalog changes (skill-forge step 6). Stamp = catalog.md's last-touching commit at generation time, not HEAD; the shipping commit is necessarily one later.

Fallback listing only, for when the claude-skills repo is unreachable. Not the catalog: no build log, no wishlist, no ledgers.

**Status (2026-08-04): all 14 are ✅ installed on Claude Code** — verified byte-identical to `~/.claude/skills/`, not merely present — **and ✅ is a per-machine claim.** On a machine that has not been through `docs/new-machine-setup.md`, none of this is installed regardless of what this file says, because hooks, `~/.claude/skills/` and the shell profile all live outside git. **The claude.ai re-upload is still outstanding**, so on rows marked `CC + ai` the `ai` half is pending rather than done — if asked for one of these on claude.ai, check before promising it.

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

## Tools & bridges

| Skill | Invocation | Purpose | Enabled |
|---|---|---|---|
| yt-gemini | auto | what's actually IN a YouTube video — visuals and audio, not captions; answer attributed to Gemini | **CC local only** |

*⚠️ **yt-gemini is the one skill in this catalog that is not available everywhere CC appears.** `CC local only` = local Claude Code on a laptop. NOT claude.ai (sandbox has no network egress to Gemini's API), and NOT cloud sessions / Claude Code on the web (no secrets store for `GEMINI_API_KEY`, and they load only skills committed to `.claude/skills/` — this one arrives via `sync.sh` → `~/.claude/skills/`). **Never recommend it outside local Claude Code.** Elsewhere, say plainly that the bridge can't run there and offer the alternative: a transcript-only reading, which covers spoken content but not what is shown. It also needs `GEMINI_API_KEY` exported in the shell profile — if that's missing, say so rather than letting the call fail.*

## Personal

| Skill | Invocation | Purpose | Enabled |
|---|---|---|---|
| bonsai-care | manual | species-aware bonsai diagnosis, care, styling | CC + ai |
| settimana-enigmistica | manual | Italian puzzle solving; anagram verification script | CC + ai |
| swiss-voting | manual | federal/cantonal votes, both committees neutrally; never advises a vote | CC + ai |

*claude.ai-primary for the last three is a usage note — where you actually reach for them — not a restriction. Everything in `skills/` syncs to Claude Code.*

# Matt vendor layer (22, verbatim @ ed37663)

**Availability is per-skill (Decision 30) — three tiers:**

- **promoted** — synced to personal Claude Code scope like my own skills; available in any directory, no install, no setup. Six skills, marked ⬆ below.
- **repo-scoped** — exists ONLY where `vendor/mattpocock/` was copied whole into that repo's `.claude/skills/` AND `/setup-matt-pocock-skills` has been run once there. State that precondition with the command, or the handover is dead on arrival.
- **n.a. on claude.ai** — the whole vendor layer is Claude Code only. None of these exist on web/mobile/desktop, promoted included.

| Phase | Skill | Tier | Invocation | Purpose |
|---|---|---|---|---|
| Setup | setup-matt-pocock-skills | repo-scoped | user | install the set into a repo — run once, before any flow |
| Setup | setup-pre-commit | repo-scoped | user | pre-commit hooks |
| Setup | git-guardrails-claude-code | repo-scoped | user | git safety rails — installs a PreToolUse hook. Run at **global** scope, once per machine (Decision 32); the hook lives in `~/.claude/`, so it never propagates with a repo. Blocks the habitual form of a destructive command, **not** a `git -C <path>` variant — say that rather than calling it a containment boundary |
| Sharpen | grill-me | ⬆ promoted | user | interview an idea into shape — no codebase |
| Sharpen | grill-with-docs | repo-scoped | user | same, with a codebase; leaves CONTEXT.md + ADRs |
| Sharpen | grilling | ⬆ promoted | model | the interview discipline itself |
| Sharpen | research | repo-scoped | model | investigate before deciding |
| Sharpen | prototype | repo-scoped | model | runnable answer to a question; reached via handoff |
| Map | wayfinder | repo-scoped | user | huge foggy effort — charts decisions, not deliverables |
| Map | to-spec | repo-scoped | user | decisions → spec |
| Map | to-tickets | repo-scoped | user | spec → tracer-bullet tickets with blocking edges |
| Map | triage | repo-scoped | user | issues piling up (only ones you didn't create) |
| Build | implement | repo-scoped | user | one ticket, fresh context; drives tdd, closes with code-review |
| Build | tdd | repo-scoped | model | the red-green-refactor loop |
| Review | code-review | repo-scoped | user | Fowler smells + spec conformance |
| Fix | diagnosing-bugs | ⬆ promoted | model | something broken that resists a first glance |
| Fix | resolving-merge-conflicts | ⬆ promoted | model | conflict resolution |
| Maintain | improve-codebase-architecture | repo-scoped | user | spare-moment upkeep |
| Vocabulary | domain-modeling | repo-scoped | model | domain terms |
| Vocabulary | codebase-design | repo-scoped | model | module shape |
| Continuity | handoff | ⬆ promoted | user | carry context into a fresh session |
| Teaching | teach | ⬆ promoted | user | interactive multi-session course in a dedicated folder |

**Main flow:** grill-with-docs / grill-me → (handoff → prototype → handoff) → to-spec → to-tickets → implement per ticket → code-review → extra-code-review. Steps 1–3 stay in one window; each implement starts fresh. Everything in that flow except grill-me and handoff is repo-scoped — the install precondition applies.
