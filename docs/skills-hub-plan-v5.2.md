# Skills Hub — Master Plan (v5.2)

*The central project for creating, improving, and distributing my Claude Skills and project setups.*

> **Corrections applied 2026-08-04 on import to the repo — still v5.2, content otherwise unchanged.** Four claims had gone false since the file was written that morning: Decision 32's coverage count (five → **six** of seven), §7's version list (deleted rather than refreshed — `catalog.md` is the only authoritative copy, per Decision 34), the claude.ai uploads (**done**, §7 + §8), and §6 step 7's pointer to `03-catalog.md` (retired from Drive 2026-07-29; replaced by [`mirror-export.md`](mirror-export.md)). **The version number was deliberately not bumped:** on Drive a new version meant a new file because nothing could be edited in place, but in git the history *is* the version record — `git log -p` on this file shows every state, which the filename cannot. If plan versions stop earning their keep here, the honest next step is dropping the suffix entirely rather than incrementing it out of habit.

**v5.2 changes — MACHINE STATE RETIRED, SWEEP RUN (2026-08-04):** the roadmap tracked **"Laptop B sync"** and **"git-guardrails hook ×2 laptops"** as state items — claims about a machine, sitting in a queue. State rots the moment either machine is touched, and it *blocks*: the 🧪→✅ sweep had been waiting on a machine that may never be opened. Both are replaced by a procedure, **`docs/new-machine-setup.md`** in the repo — correct for one machine or five, never stale by sitting still, nothing queued behind it. **Decision 32 restated** accordingly: it records the hook's design and that installation is per-machine, pointing at the runbook, and now carries the **measured coverage boundary** (below). **🧪→✅ sweep executed** for 13 of the 14 catalog rows (bonsai-care was already ✅), on **Claude Code evidence only** — all 14 skills verified byte-identical to `~/.claude/skills/`, not merely present. **✅ redefined as a per-machine claim** ("installed per enabled-where on the machine you are reading this on"), which removed the *machine* axis and deliberately **not** the *surface* axis: the claude.ai re-upload is still outstanding, so on `ai ☑` rows ✅ asserts CC and anticipates claude.ai. ask-tete → **1.0.5** (snapshot regenerated, stamped `@8f9932e`, blanket-🧪 header replaced by the two-axis truth). extra-code-review Security axis: prose scope now keyed to **whether a claim is load-bearing**, not to its being prose. Repo commits `8f9932e` + `923e6ed`. **Counts corrected where they are instructions rather than measurements** — the catalog is 14 skills, so `sync.sh` expects **14 + 6 = 20**; the context-ledger figures keep their original numbers because a measurement is provenance, not a live count. Everything from v5.1 carried over unchanged below except where marked.

**v5.1 changes — TESTS PASSED, VENDOR SCOPE OPENED (2026-07-28, post-test session):** skill test plan v1 executed — **13/13 routing, 0 false positives, 12 PASS / 1 FIX BODY**; all fixes applied and re-tested PASS (skill-forge invocation-question + drafting gate → 1.1.x; Drive-only stubs + unreachable caveat on the three cascade skills → 1.0.1; ask-tete vendor-availability rule → 1.0.1, bare-invocation catalog listing with live-read/snapshot fallback → 1.0.2, three-tier availability → 1.0.3). **Decision 30:** vendor scope is per-skill via the catalog ledger — six standalone vendor skills (teach, handoff, grilling, grill-me, resolving-merge-conflicts, diagnosing-bugs) **promoted to personal CC scope** via sync.sh's `PROMOTED_VENDOR` list (pair guard grilling+grill-me; collision guard vs skills/). **Decision 31:** `scripts/install-vendor.sh` built & smoke-tested 7/7 — whole-set install into any repo with sha256 pin verification (both directions), partial-install guard, `--private` mode (`.git/info/exclude`: `.claude/skills/`, `docs/agents/`, `.scratch/`) for laptop-only installs; **--private and cloud sessions are mutually exclusive by design**. **Decision 32:** git-guardrails is installed as a **global PreToolUse hook**, not a resident skill (hooks-over-prose applied to itself). **Decision 33:** the catalog's enabled-where column **records reality** (sync.sh syncs all of skills/; the three "claude.ai-primary" skills are CC ☑ + ai ☑ with primary-surface as a usage note); its discipline applies force only under budget pressure. Context ledger: post-promotion resting ≈25.7k, skills 3.4k/31 (six promoted descriptions cost ~0.1k). Banked constraints: **claude.ai skills cannot persist files** (advise, never track — accumulating state routes to a project or a CC-side skill; settle surface capability before invocation mode); **snapshot stamping = the referenced file's last-touching commit, never --amend**. Test plan v2 in `tests/` for future regression runs. Deploy-checklist visibility gap: operator's-guide §5 condensed into README; deploy-check.sh parked (build when drift hurts). Everything from v5 carried over unchanged below except where marked.

**v5 changes — PHASE 0 CLOSED, PHASE 1 EXECUTED (2026-07-28):** repo live as **`stefanosimao/claude-skills`**; vendor layer (22 skills @ `ed37663` + 22 clean audits); Skill-Library batch complete (127 summaries + the ai-llm-engineering folder later the same day), verified, on Drive, fetch-tested; baseline context audit (26.8k / 3%); aihero "kill the bloat" config rejected; all 13 original skills draft-built; open decisions 1–2 resolved (copy-mode sync; repo created).

*(v4, v3.x, v2 change history unchanged — see v5 archive.)*

---

## 1. Project Description — unchanged from v5

## 2. Architecture: Hub and Spokes

Unchanged from v5, with these amendments:

### Scope model (amended by Decision 30)

| Scope | What lives there | How it arrives |
|---|---|---|
| Personal CC (`~/.claude/skills/`) | my 14 + the 6 **promoted vendor** skills | `./scripts/sync.sh` (PROMOTED_VENDOR list; pair + collision guards) |
| claude.ai account | my skills per enabled-where; **never vendor skills** (teach/handoff write files; claude.ai can't persist) | Save-skill / zip upload |
| Repo-scoped (`<repo>/.claude/skills/`) | the whole 22-skill vendor set (and any of mine committed per-repo) | `./scripts/install-vendor.sh <repo>` — shared (committed → team + cloud) or `--private` (git-excluded → laptop-only, no cloud) |
| Global hooks | git-guardrails' PreToolUse hook | `docs/new-machine-setup.md` step 4 — global scope, skill not resident, **per machine** |

**Promoted vendor set (Decision 30):** teach · handoff · grilling · grill-me · resolving-merge-conflicts · diagnosing-bugs. Criteria: standalone per audits (no tracker/`docs/agents/`/setup deps) + useful outside codebases. Verbatim + pin discipline unchanged; only scope changed. grilling+grill-me sync as a pair (wrapper needs engine).

### What does not travel with the repo (added v5.2)

`git pull` brings the repo and nothing else. Three things live outside the working tree by design, and each is therefore **per machine**: the **shell profile** (`~/.zshenv` — keys), **Claude Code hooks** (`~/.claude/settings.json` + `~/.claude/hooks/`), and the **account-wide skill install** (`~/.claude/skills/`, written by `sync.sh`). Corollary worth stating once: **there is no single source of truth across machines for any of the three.** Editing the guardrail's pattern list on one machine leaves the others silently divergent. Procedure: `docs/new-machine-setup.md`.

### Context budget — measured, currently a non-issue

Baseline 26.8k/3% → post-bulk-sync skills 3.3k → post-promotion **3.4k for 31 skills (0.3%)**. Only frontmatter descriptions load at rest, not bodies. The escape valve (demote to manual) and the audit rules remain in force but nothing currently needs them. Rerun `/context` after every propagation wave. *(These are measurements with their original counts — provenance, not live totals.)*

### Invocation policy — unchanged, plus one banked constraint

**Surface capability precedes invocation mode:** claude.ai skills cannot write persistent files (per-conversation sandbox) — they advise, never track/log. Anything accumulating state routes to a project or a Claude Code-side skill. (In skill-forge `references/conventions.md`.)

## 3. Project Knowledge — documents

Unchanged, plus: `session-handoff-2026-07-28-post-test.md` (session record), test artifacts live in repo `tests/` (plan v1, v2, report + addenda). **Added v5.2:** `docs/new-machine-setup.md` in the repo is the machine runbook — referenced from here rather than duplicated, so it cannot drift.

## 4. Reference Sources — unchanged from v5

## 5. Skill vs Project vs Hybrid — unchanged from v5

*(Applied addition: `_projects/ai-llm-engineering/` — 6 books / 5 summaries, feeds the AI project, project-setup test #2; no skill.)*

## 6. Workflows

Unchanged, plus:

### F. Deploy / propagate (operationalized 2026-07-28; machine steps split out v5.2)
1. Commit + push (never let commits pile up unpushed on one disk).
2. Each machine: `git pull && ./scripts/sync.sh` → expect **"14 + 6"** (20 folders). Verify current, not merely present: `cd skills && for s in *; do diff -rq "$s" ~/.claude/skills/"$s" >/dev/null || echo "STALE: $s"; done`.
3. claude.ai: re-upload changed skills per enabled-where (delete old version first).
4. Repos needing the pipeline: `./scripts/install-vendor.sh [--private] <repo>` → `/setup-matt-pocock-skills` once there.
5. `/context` → append to the catalog's audit ledger.
6. Catalog: versions bumped, enabled-where ticked, 🧪→✅ **per the ✅ definition — a per-machine claim, and only for surfaces actually installed** (a row marked `ai ☑` needs the upload done, not merely intended); if catalog.md changed, regenerate ask-tete's snapshot (stamp = catalog.md's last-touching commit, never --amend).
7. Re-export the Hub mirror per [`mirror-export.md`](mirror-export.md) — three files, each stamped with the commit it came from. *(Replaces "mirror `03-catalog.md` into project knowledge": that file was retired from Drive on 2026-07-29 for going stale, and the mirror is now a stamped export rather than a copy.)*

**A machine that has never been set up needs the full runbook, not step 2** — `docs/new-machine-setup.md` covers clone · `~/.zshenv` key · sync · guardrails hook · vendor install · baseline audit.

## 7. Skill Inventory & Catalog Seed

As v5, with status: **all 13 originals tested PASS (v1 run + targeted re-tests)**, plus yt-gemini (14th, 4/4). **Versions are not restated here — `catalog.md` is the single authoritative copy** (Decision 34), and a second list is a second thing to forget: the three quoted in v5.2 were already stale within the day. Promoted vendor subsection also lives in catalog.md. **🧪→✅ sweep DONE (2026-08-04)** for 13 of the 14 rows (bonsai-care was already ✅), on Claude Code evidence — **and the claude.ai uploads landed later the same day**, so `ai ☑` rows now record both surfaces rather than anticipating one. Two standing exclusions: `yt-gemini` never goes to claude.ai, and `bonsai-care` was already live and unchanged.

## 8. Phased Roadmap

- **Phase 0** ✅ closed · **Phase 1** ✅ done · **Phase 2** ✅ absorbed
- **Phase 1.5 — Test & deploy: DONE.** claude.ai uploads landed 2026-08-04 (12 eligible skills; `yt-gemini` never eligible, `bonsai-care` already live). Mirror refresh is no longer a queue item but a **standing rule** — see [`mirror-export.md`](mirror-export.md), triggered by any `catalog.md` change rather than tracked here. *(Removed as tracked items 2026-08-04: "Laptop B sync" and "git-guardrails hook ×2 laptops" were machine state, not work — machine currency is now `docs/new-machine-setup.md`, run on demand. "🧪→✅ sweep" is done.)*
- **Phase 3 — projects pending:** good-father (test #1) → AI project on `_projects/ai-llm-engineering/` (test #2) → QC, SWE. Then interview-answer-coach rebuild via skill-forge.
- **Ongoing:** superpowers/awesome-list enrichment; catalog maintenance; periodic improvement passes.

**Roadmap convention (added v5.2): the queue holds work, never machine state.** "Machine X is behind" is checked by running the runbook, never tracked here — a state item rots on any touch and blocks whatever queues behind it.

## 9. Division of Labor — unchanged from v5

## 10. Decisions

1–29: unchanged from v5.

**Resolved:**
30. **Vendor scope is a per-skill decision via the catalog ledger.** Six standalone skills promoted to personal CC scope (teach, handoff, grilling, grill-me, resolving-merge-conflicts, diagnosing-bugs); verbatim + pin rules unchanged. "Repo-only" was a budget precaution, now measured obsolete.
31. **install-vendor.sh is the vendor distribution path** (whole-set, sha256 pin-verified both directions, partial-guard, `--private` = git-excluded laptop-only). Cloud sessions require committed skills — private and cloud are mutually exclusive.
32. **git-guardrails = global PreToolUse hook, not a resident skill.** A guardrail that depends on the model choosing to invoke it is not a guardrail; the hook fires on the tool call whether or not any skill is loaded, and costs zero resting context. **Installation is per-machine and does not travel with the repo** — the hook lives in `~/.claude/`, which `sync.sh` never writes to, so a fresh clone has no guardrail. Procedure: `docs/new-machine-setup.md` step 4, including verification (registration grep + a live blocked `reset --hard` on a confirmed-clean tree — check the tree first, since testing a guardrail means deliberately performing the dangerous operation). *This plan records the design, not which machines have run it.* **Coverage boundary, measured 2026-08-04:** the nine patterns match as substrings anywhere in the command, and **seven carry a literal `git ` prefix while only two stand alone.** So a path-prefixed `-C <path>` form **slips past six of the seven** (`push`, `clean -fd`, `clean -f`, `branch -D`, `checkout .`, `restore .`); only `reset --hard` is still caught, because it also stands alone. `cd /other && git push` is still caught. *(Corrected from "five" 2026-08-04: the original count was read off an enumeration that had dropped `clean -f`. Re-established by executing the hook against all nine patterns in both forms.)* **It is a brake on the command you would type by habit, not a containment boundary** — it stops the accident, not an adversary. Recorded because the gap was first found by generalizing from a single lucky sample and then checking; the bluntness is deliberate (a matcher clever enough to parse intent is also clever enough to be talked around) and its price is false positives, which are cheap.
33. **enabled-where records reality;** sync.sh syncs all of `skills/`; the column's discipline applies force only under budget pressure. "claude.ai-primary" is a usage note, not a restriction. **Amended v5.2:** ✅ is a **per-machine** claim, and the redefinition removed the machine axis **only** — the surface axis still binds, so ✅ on an `ai ☑` row requires the upload to have happened.

**Open:**
3. Further Layer-2 complements — revisit only if practice surfaces gaps.
4. ~~Context send/block policy~~ → effectively resolved by measurement: all 13 + 6 = send; block list empty; revisit on budget pressure.
5. Model-tier provenance in summaries (F5) — optional, unchanged.
6. deploy-check.sh (parked) — build if version drift between catalog and synced skills actually bites; candidate shape: `sync.sh --check`.
