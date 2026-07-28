# Audit — setup-matt-pocock-skills (read-understand-gap)

*Workflow C pass, per Decision 23 (verbatim keep — audit maps dependencies, checks security, finds gaps; no edits). Audited @ `ed37663`, 7 files, 419 lines total. Date: 2026-07-28.*

## 1. What it does

One-time, per-repo scaffolding for the engineering pipeline. `disable-model-invocation: true` — a pure user-invoked orchestrator, run once per repo. Prompt-driven (explore → present → confirm → write), not a script. It writes:

- `docs/agents/issue-tracker.md` — where issues live: **GitHub** (`gh` CLI), **GitLab** (`glab`), **local markdown** (`.scratch/<feature>/`), or freeform "other"
- `docs/agents/triage-labels.md` — maps the 5 canonical triage roles (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`) to the repo's actual label strings; **written only if the triage skill is installed**
- `docs/agents/domain.md` — consumer rules for `CONTEXT.md` + `docs/adr/` (single-context default; multi-context only on monorepo signals)
- An `## Agent skills` block (3 one-liners + pointers) into the **existing** `CLAUDE.md` or `AGENTS.md` — never creates one when the other exists, updates in-place, asks if neither exists

Notably careful behaviors: leads each question with a recommended answer; skips sections exploration already settled; "PRs as a triage surface" flag defaulted off and deliberately not raised.

## 2. Dependency map (why this skill is the keystone)

**Consumers of its output:**
| Output | Read by |
|---|---|
| issue-tracker.md | to-tickets, to-spec, triage, wayfinder (map/child-ticket/blocking/frontier operations), implement, code-review (spec axis) |
| triage-labels.md | triage |
| domain.md (CONTEXT.md/ADR rules) | grill-with-docs, domain-modeling, codebase-design, improve-codebase-architecture, implement — "use the glossary's vocabulary; flag ADR conflicts, never silently override" |

**External dependencies:** `gh` CLI (GitHub mode) or `glab` (GitLab mode). **Local-markdown mode has zero external dependencies** — the full pipeline (including wayfinder's map/ticket/blocking mechanics, spec'd file-by-file in issue-tracker-local.md) runs on nothing but the filesystem.

**Detection coupling:** Section B checks whether `triage` is installed *alongside*. Implication for our vendor layout: when copying Matt skills into a work repo's `.claude/skills/`, copy the set together (or at least triage with setup) so detection sees reality.

## 3. Security

Clean. No scripts in this skill; writes only markdown under `docs/agents/` and one section of CLAUDE.md/AGENTS.md, with explicit confirm-before-write and don't-overwrite-user-edits rules. `agents/openai.yaml` is interface metadata.

## 4. Gaps & implications for our system

1. **Local-markdown mode solves the work-laptop constraint.** No tracker, no `gh`, no external data flow — the accepted split (single-model Claude on work code) can still run the full pipeline via `.scratch/`. This upgrades what we thought was possible on the work machine.
2. **ADR home is now canonical:** `docs/adr/` (root) + `src/<context>/docs/adr/` (multi-context). The codebase-memory-mcp trial must conform to this or stay out (resolves the conflict flagged in the master plan's parked-tooling note).
3. **CLAUDE.md footprint is tiny by design** — the block is pointers, detail lives in `docs/agents/` (progressive disclosure). Send/scope/block verdict: the block is fine; it's exactly the hooks-over-prose economy applied to docs.
4. **No gap requiring a complement.** The one freeform edge ("other" trackers = prose description) doesn't affect us — we'll use GitHub (personal) and local-markdown (work).
5. **Operator's-guide addition (proposed):** new step in §4 — after copying Matt skills into a work repo, run `setup-matt-pocock-skills` once in that repo before using any pipeline skill.

## 5. Verdict

**KEEP verbatim** (already vendored). No complement needed. Two follow-ups: the operator's-guide step (item 5) and the copy-the-set-together rule (item 2 of §2). Audit queue next candidates: the grilling trio (internal-overlap question) or wayfinder (heaviest orchestrator).
