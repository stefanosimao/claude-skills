---
name: skill-forge
description: "Build, improve, or import a Claude skill my way — full loop from intent capture to packaged .skill, with house conventions. Invoke by name."
---

# Skill Forge

The skill that builds skills. Wraps Anthropic's skill-creator loop with my house rules. Three modes — pick from the user's intent:

- **CREATE** a new skill → run the full loop below.
- **IMPROVE** an existing one → load it, run the audit checklist (references/checklist.md), revise, re-test the prompts that failed, bump version.
- **IMPORT** a third-party skill → NEVER install directly: clone in-session, line-by-line security & quality audit (scripts especially), adapt to my conventions, it enters MY repo under my name. One skill per pass: show → critique → taste calls → adapted version. Exception: the Matt layer is vendored VERBATIM and pinned — imports there are re-audits + pin bumps, never edits.

## The loop (CREATE)

1. **Capture intent.** Interview briefly: what it does, when it should fire, what output looks like, which surface(s) it lives on. Then apply the Skill-vs-Project-vs-Hybrid framework (project-setup owns it) — confirm a skill is even the right container before drafting.
2. **Propose invocation, then WAIT** — it shapes the description, and it is the user's call, never the forge's. Never decide it unilaterally: state one recommendation with its reasoning plus the alternative, then stop. E.g. *"I'd propose auto(narrow) — the trigger is a recognizable domain topic the model spots better than you do. Alternative: manual, if firing uninvited would disrupt. Confirm or override before I draft."* The menu below is the catalog's invocation policy; the user picks from it.
   - *Auto / model-invoked*: the trigger is a recognizable domain or reusable discipline the model spots better than the user. Description written PUSHY: front-load the leading word, one trigger per genuinely distinct branch, no synonym padding.
   - *Manual / user-invoked*: heavy multi-step orchestrators, or budget-demoted skills. Description TERSE — a one-line human-facing summary ending "Invoke by name." The user (or ask-tete) is the index.
   - Hierarchy rule: orchestrators may invoke disciplines, never other orchestrators.
   - **Drafting gate:** produce no SKILL.md and no reference files while any intake question you yourself flagged as blocking stays unanswered — invocation mode included. A "sketch" request earns an outline of the intended structure, never the artifacts themselves.
3. **Draft** SKILL.md per the conventions (references/conventions.md): <500 lines, progressive disclosure into `references/`, completion criteria on steps, leading words over restatements, positive phrasing over prohibitions, scripts over prose where deterministic, hooks over prose where enforcement must be certain.
4. **Test.** Claude Code: spawn test subagents against realistic prompts (should-fire, shouldn't-fire, and edge phrasings); run the description-optimization loop on auto skills. claude.ai: lighter inline sanity checks. Prefer Claude Code for anything auto-invoked.
5. **Review & iterate** — the user judges, forge revises. Repeat 3–5 until the failing prompts pass.
6. **Package & deploy.** Output: committable folder for `skills/` in the claude-skills repo + packaged `.skill`/zip for one-click save. Then remind the propagation steps: commit+push → `git pull && ./scripts/sync.sh` on each machine → claude.ai Save-skill/upload (delete old version first) → catalog.md updated (version, invocation, enabled-where). A machine not yet set up needs `docs/new-machine-setup.md`, since hooks, `~/.claude/skills/` and the shell profile live outside git and no pull brings them. **If catalog.md changed, TWO derived things are now stale, and they are one step, not two to remember:** (a) regenerate `ask-tete/references/catalog-snapshot.md` from it and bump ask-tete's patch version — the snapshot is ask-tete's offline fallback, and on claude.ai it is not a fallback at all but the primary listing; (b) re-export the Hub mirror per `docs/mirror-export.md` — the claude.ai project holds a stamped copy of catalog.md, README.md and the plan, because the repo is private and a Hub session cannot fetch it. Both answer the same question — *what derives from this file and is now behind* — so treat "catalog.md changed" as the trigger for the pair. Stamp its header with **catalog.md's last-touching commit at generation time** (`git log -1 --format=%h -- catalog.md`, run BEFORE committing), never HEAD: the honest referent is which catalog state the snapshot mirrors, and HEAD drifts ahead on every unrelated commit. Don't amend the stamp to match the shipping commit — a file cannot hold the hash of the commit that contains it, and amending only rewrites the hash again. **If the skill count changed, grep for its DERIVED numbers too, not just the count** — the folder total `sync.sh` prints (`N + 6 promoted`), the test plan's scope line, and its §0 setup-check number are all computed from it, so a search for the old count never finds them. Proven twice on 2026-08-04: a sweep correctly fixed "MY 13 skills" and left "19 folders (13 + 6 promoted)" behind, which would have failed the setup check outright on a clean run — **a stale doc that misinforms is annoying; one that makes a verification step fail is actively harmful.** **After a claude.ai upload, record in the catalog build log which skills went up at which versions.** A `SKILL.md` carries no version field — checked 2026-08-04, and the claude.ai UI shows only name and description — so an uploaded artefact is unidentifiable once it leaves: there is no way to tell which version is live by looking at it. That build-log line is the only record, which makes writing it part of the upload, not bookkeeping after it.

## Non-negotiables (any mode)

- **Catalog discipline:** no skill ships without its catalog.md entry updated. New ideas that arrive mid-forge get PARKED in the backlog, not built.
- **Repo scoping:** a skill needed in one codebase only goes to that repo's `.claude/skills/` (wins on name clash, costs zero personal budget) — never account-wide by default.
- **Budget check:** before adding an auto skill, ask whether an existing skill's territory covers it (fewer, consolidated skills beat many narrow ones) and whether manual + ask-tete discovery would serve. The escape valve is demotion to manual, not deletion.
- **Trigger-collision check:** compare the new description against every enabled auto skill; competing similar triggers = unpredictable routing. Fix with distinctive descriptions or explicit exclusions ("do NOT use for X — that's <skill>'s territory").
- **Book-grounded skills** encode the fetch cascade: distillation in the skill → `Skill-Library/<folder>/_summaries/<slug>.md` on Drive (filename search — folder browsing doesn't work; never trust modifiedTime, verify by content) → full book only if the summary points deeper.

## References

- `references/conventions.md` — drafting rules distilled from Anthropic's skill-creator + Matt's writing-great-skills (leading words, information hierarchy, failure modes: premature completion, duplication, sediment, sprawl, no-ops, negation).
- `references/checklist.md` — the improve-mode audit checklist.
