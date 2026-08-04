# Workflow Playbook — Which Skills, When (v1.2)

*Project-files reference. Three walked-through scenarios using the deployed catalog (mine + vendor layer). When a situation doesn't match a scenario: `/ask-tete`. **v1.2 (2026-08-04):** the guardrail line said the hook "blocks destructive git silently", which overstates a security control — corrected below to what was measured. **v1.1:** corrections from the vendor validation (2026-08-03) — branch-before-implement, the diagnosing-bugs trigger rule, local-tracker done convention, public-triage caution made concrete.*

---

## Scenario 1 — Building new software (greenfield)

**Setup (once per repo):**
```bash
mkdir project && cd project && git init
~/claude-skills/scripts/install-vendor.sh .     # whole pipeline (22 skills), pinned + verified
/setup-matt-pocock-skills                        # once — it reads the environment and recommends the tracker (no remote → local-markdown, zero deps)
```

**The 7 phases:**

| Phase | Command | What happens |
|---|---|---|
| 1 Idea | `/grill-with-docs` | one-question-at-a-time interrogation, recommended answers, decisions land in CONTEXT.md + ADRs. Validated bonus: it finds defects the feature request never mentioned (the wcstat run surfaced two). **Huge foggy multi-session effort?** `/wayfinder` instead — never for well-scoped features. |
| 2 Research *(opt.)* | `/research` | background agent reads PRIMARY sources, writes one cited md into the repo |
| 3 Prototype *(opt.)* | `/prototype` | throwaway code answering ONE design question; validated decision folds into real code |
| 4 PRD | `/to-spec` | synthesizes the CURRENT conversation (keep 1–4 in one window); test seams first; no file paths |
| 5 Kanban | `/to-tickets` | tracer-bullet vertical slices with blocking edges; granularity quiz before publishing |
| 6 Build | **branch first**, then `/implement` per ticket — fresh session each | ⚠️ implement commits to the **current** branch by contract — it does not branch for you. It fetches ADRs off ticket cross-references itself. tdd runs at the pre-agreed seams; `/handoff` if context degrades |
| 7 QA | `/code-review` (auto at implement's end) + `/extra-code-review` (manual, alongside) | his axes: standards + spec. Mine: security, defects, performance, tests — including the mutation check that catches tests never shown able to fail. Reports never merged |

**Ad-hoc, any phase:** `software-engineering` (auto) for design/practice questions with canon citations · **`diagnosing-bugs` — say "debug this" or invoke by name**: symptom-only phrasing fires it ~1/6; with the trigger word it's reliable, and firing is what buys you the red-first discipline (fix arrives with a test that failed before it) · `resolving-merge-conflicts` fires itself mid-merge · the git-guardrails hook is **a brake on the habitual form of a destructive command, not a containment boundary** — measured 2026-08-04, **six of its seven `git `-prefixed patterns fall to the `git -C <path>` form** (only `reset --hard` survives, because it also stands alone). It stops the accident, not an adversary; don't lean on it as a safety net.

**Local-markdown tracker convention:** the five labels have no "done" — when a ticket ships, hand-edit its `Status:` line to `done — <commit>`.

## Scenario 2 — Returning to an old repo

1. Vendor set absent → `install-vendor.sh` + `/setup-matt-pocock-skills` once (its explore-first design doubles as re-orientation).
2. **Re-entry:** CONTEXT.md / `docs/adr/` exist → read those; they're the re-entry docs (validated: implement and triage genuinely use them). Nothing there → `/improve-codebase-architecture` for the hot-spot scan; `domain-modeling` builds the glossary as you touch things.
3. New feature → pipeline from Phase 1. Bug → "debug this" / `diagnosing-bugs`.

## Scenario 3 — Intern's repo: track, review, teach

**Setup:** `install-vendor.sh --private <her-repo>` — tooling local, nothing reaches her remote. Private = laptop-only; cloud sessions won't have it.

- **Track:** `/triage` — reproduces claims before believing (validated: it falsified a bug report with actual commands and closed it citing CONTEXT.md + ADR + spec). ⚠️ On GitHub-tracker repos it **creates labels and posts public AI-disclaimed comments** — on a public repo that's visible to everyone; pair private mode with the local-markdown tracker if her repo shouldn't show AI comments.
- **Review:** `/code-review` + `/extra-code-review` on her branches — the four extra axes are the junior blind spots, and the mutation check catches "coverage that isn't".
- **Teach from reviews:** `software-engineering` turns findings into canon-grounded lessons · `/grill-me` on her design with her present · recurring gaps → `study` builds a reading path.
- **Not `/teach`** — that's a workspace for teaching *you*; she'd run her own.

---

## Quick reference — invocation cheat sheet

| Situation | Reach for |
|---|---|
| "What should I use for…?" | `/ask-tete` (bare = full catalog with availability) |
| New idea, any size | `/grill-me` (no codebase) · `/grill-with-docs` (in one) · `/wayfinder` (huge + foggy) |
| Conversation → committed work | `/to-spec` → `/to-tickets` → branch → `/implement` (fresh sessions) |
| Any diff worth trusting | `/code-review` + `/extra-code-review` |
| Bug where the discipline matters | **"debug this"** or `diagnosing-bugs` by name — symptom-only phrasing usually won't fire it |
| Context window degrading | `/handoff` |
| Design/practice question | `software-engineering` (auto) |
| Learn a topic | `study` (paths from my library) → `/teach` (interactive workspace, CC only) |
| New repo, first time | `install-vendor.sh [--private]` → `/setup-matt-pocock-skills` |
