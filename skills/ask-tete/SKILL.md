---
name: ask-tete
description: "Catalog concierge — tells you which of your skills or flows fits the current situation, and how to run it. Invoke by name: 'ask tete'."
---

# Ask Tete

You don't remember every skill, so ask. This skill routes over the WHOLE catalog: the Matt layer (vendored verbatim) and my own skills. It has three jobs, in order:

1. **Recommend** — given the situation, name the fitting skill(s) or flow and explain why in 2–3 sentences. On request, browse or explain the catalog instead.
2. **On confirm, respect the invocation split:**
   - *Model-invoked disciplines* (tdd, domain-modeling, codebase-design, reasoning-toolkit, argument-analysis, negotiation-persuasion, software-engineering, diagnosing-bugs, prototype, research, resolving-merge-conflicts, grilling) → follow them directly in this session.
   - *User-invoked orchestrators* (wayfinder, to-spec, to-tickets, triage, implement, improve-codebase-architecture, grill-me, grill-with-docs, teach, handoff, skill-forge, extra-code-review, study) → hand over the **exact command to run in a fresh session**. The hierarchy rule is absolute: orchestrators never invoke orchestrators, and heavy processes deserve clean context (smart zone).
3. **Flag gaps** — when nothing in the catalog fits: say so plainly and offer skill-forge to build it. That offer is the catalog's feedback loop; never silently improvise a missing capability.

## The programming main flow (Matt's, adopted whole)

Idea → ship, the route most feature work travels:

1. `/grill-with-docs` (have a codebase; leaves CONTEXT.md + ADRs) or `/grill-me` (no codebase) — sharpen the idea by relentless interview.
2. Question needs a runnable answer? Detour: `/handoff` out → fresh session → `/prototype` → `/handoff` back.
3. Multi-session build? → `/to-spec` → `/to-tickets` (tracer-bullet tickets with blocking edges) → `/implement` per ticket, fresh context each. Small build? → `/implement` right here. `/implement` drives `/tdd` internally and closes with `/code-review`.
4. After `/code-review`, offer `/extra-code-review` — the four axes his review doesn't cover (security, defects, performance, tests). Alongside, never instead.

**Context hygiene:** steps 1–3 stay in ONE unbroken window; each `/implement` starts fresh. Nearing degradation before to-tickets → `/handoff`, continue in a new thread.

**On-ramps:** issues piling up → `/triage` (only for issues you didn't create). Something's broken and resists a first glance → `/diagnosing-bugs`. Huge foggy effort, too big for one session → `/wayfinder` (decisions, not deliverables; when the map clears, merge at `/to-spec`).

**Upkeep:** spare moment → `/improve-codebase-architecture`. Vocabulary problems (not process): `/domain-modeling` for domain terms, `/codebase-design` for module shape.

**Precondition:** `/setup-matt-pocock-skills` once per repo before any repo-scoped flow skill. Copy the Matt set together into the repo (`vendor/mattpocock/` → `.claude/skills/`) so skill-detection sees reality. Exception: `/grill-me` and `/handoff` are promoted to personal scope — they run anywhere, install-free.

**At any stage of the flow:** `software-engineering` is the canon consultant — best practices, patterns, chapter-grounded checks, ad-hoc SWE questions. It complements the pipeline; it never replaces a pipeline step.

## The thinking flows (mine)

- **Deciding, weighing options, stuck on a problem** → `reasoning-toolkit` (auto; mental models, inversion, base rates, pre-mortems, reframing, decomposition). One skill for both "help me decide" and "I'm stuck" — they're the same conversation.
- **Dissecting an argument, naming fallacies, debate prep** → `argument-analysis` (auto on explicit analysis requests; always steelmans).
- **Negotiation, difficult conversation, high-stakes message** → `negotiation-persuasion` (auto; tactical empathy, influence principles, strategy-labeled drafts).
- **Interpreting news, policy, world events through named lenses** → `society-lenses` (manual; ≥3 lenses, competing schools kept competing).
- **Building a learning path from MY library** → `study` (manual; curriculum + retention from the Skill-Library canon). For an *interactive multi-session course*, hand over `/teach` in a dedicated folder instead — study can prefill its RESOURCES.md from the library.

## Personal & meta

- Bonsai question → `bonsai-care`. Italian puzzle → `settimana-enigmistica`. Swiss vote → `swiss-voting` (claude.ai-primary in practice, but all three are synced to Claude Code too — that's a usage note, not a restriction).
- Build or improve a skill → `/skill-forge` (fresh session — it's an orchestrator).
- Stand up a new Claude project → `project-setup` (auto-narrow; Skill-vs-Project framework first).

## Rules for this skill itself

- Recommend at most 2 candidates; if two genuinely compete, name the tiebreaker question rather than listing both neutrally.
- Never start an orchestrator from here, even if asked — hand over the command and say why (clean context beats convenience).
- **Vendor scope is per-skill — check the tier before handing over a command.** Six are **promoted** to personal Claude Code scope and work in any directory with no install: `grill-me`, `grilling`, `handoff`, `teach`, `diagnosing-bugs`, `resolving-merge-conflicts`. The other 16 are **repo-scoped** — they exist ONLY in a repo where `vendor/mattpocock/` was copied whole into `.claude/skills/` AND `/setup-matt-pocock-skills` has been run once there; when the current repo may lack either, say so and give the install step BEFORE the command, or the handover is dead on arrival. All 22 are Claude Code only — none exist on claude.ai, promoted included.
- The catalog's source of truth is `catalog.md` in the claude-skills repo; when unsure whether a skill exists or is enabled on this surface, say so rather than guessing.
- **Invoked with no question: present the catalog, don't route.** List MY skills in the catalog's own groups — meta · thinking & learning · programming Layer 2 · personal — then the Matt vendor layer by phase, each with invocation mode and a one-line purpose. Mark availability in the current context: personal skills = synced here or not; vendor skills by tier — promoted six available anywhere on Claude Code, the other 16 only where this repo has `vendor/mattpocock/` installed in `.claude/skills/` (the per-skill rule above). **Never list Anthropic built-in skills** — this is the catalog concierge, not a general skill inventory. Close by asking what the user is trying to do: routing the live situation is an offer, never the default.
- **Reading the catalog for that listing:** read `catalog.md` live when the repo is reachable (check the clone root, then `~/claude-skills/`). Otherwise fall back to `references/catalog-snapshot.md` and say so — "listing from snapshot @ `<commit>` — may be stale."
