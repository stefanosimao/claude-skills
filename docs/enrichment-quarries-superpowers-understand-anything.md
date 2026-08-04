# Enrichment Quarries — superpowers & Understand-Anything (v1)

*Project-files doc for the "Ongoing: superpowers/awesome-list enrichment" roadmap line. Two repos enumerated in-session 2026-07-29; verdicts below feed the Workflow C queue. Neither repo gets installed directly — audit-first rule applies throughout.*

---

## 1. obra/superpowers — enumerated @ `44c9b2d` (2026-07-27), 14 skills

Character: pure skill set (SKILL.md folders), same species as the Matt layer. Cherry-pick candidates, adapted into `skills/` under my name (Workflow C), never vendored — unlike Matt's set there is no pipeline coherence to preserve, so per-skill adoption is correct.

### Verdict table

| Superpowers skill | Verdict | Why |
|---|---|---|
| brainstorming | **skip** | ≈ grilling/grill-me; Matt's is deeper (recommended answers, decision tree) |
| writing-plans / executing-plans | **skip** | ≈ to-spec / to-tickets / implement |
| requesting-code-review | **skip** | ≈ code-review's function |
| writing-skills | **skip** | ≈ writing-great-skills, already absorbed into skill-forge refs |
| using-superpowers | **skip** | his ask-tete; mine exists |
| test-driven-development | **compare** | quarry vs Matt's tdd — dossier already queued this comparison |
| systematic-debugging | **compare** | quarry vs diagnosing-bugs — dossier already queued this |
| receiving-code-review | **GAP → audit** | how to *react* to review feedback: verify before implementing, no performative agreement. Neither review lane covers the receiving side. Natural pairing: runs after /code-review + /extra-code-review output |
| verification-before-completion | **GAP → audit first** | evidence before any "done/fixed/passing" claim. Pure standalone discipline, cheap, wanted everywhere — best candidate of the three; would live in `skills/` as model-invoked |
| finishing-a-development-branch | **GAP → audit** | integrate/merge/cleanup decision at branch end; Matt's pipeline stops at commit |
| dispatching-parallel-agents / subagent-driven-development | **park** | reading material for the deferred graph-engineering work (summarization/verification fan-out); revisit when that unparks |
| using-git-worktrees | **maybe** | small isolation utility, no equivalent; take only if worktrees enter the workflow |

### Audit plan (Workflow C, one skill per pass)

1. **verification-before-completion** — line-by-line audit → adapt → my repo (likely near-verbatim, renamed/re-described to avoid any trigger ambiguity). Invocation: model-invoked; measure resting cost before enabling account-wide.
2. **receiving-code-review** — audit → adapt; check interaction with the two review lanes (it must not re-run reviews, only govern the response to findings).
3. **finishing-a-development-branch** — audit → decide adapt-vs-skip; overlap check vs resolving-merge-conflicts (different concern: decision vs procedure — expected clean).
4. Comparison passes (tdd, systematic-debugging) — read side-by-side with Matt's, harvest deltas into notes; **no edits to vendored skills** — any adopted delta becomes complement material or waits for an upstream pin bump.
Naming rule check: these are not complements to a specific Matt skill, so no `extra-*` prefix; plain names in `skills/`, catalog entries with the usual columns.

---

## 2. Egonex-AI/Understand-Anything — enumerated @ `2544283` (2026-07-28), v2.9.4

### What it is

**Not a skill set — a Claude Code plugin with heavy infrastructure.** 9 skills (`/understand`, `-chat`, `-explain`, `-onboard`, `-diff`, `-domain`, `-dashboard`, `-knowledge`, `-figma`) sitting on a Node/TypeScript toolchain: tree-sitter WASM parsers, deterministic extraction scripts (`.mjs`/`.py`), a React dashboard, and a local viewer server. `/understand` runs a 7-phase multi-agent pipeline producing `knowledge-graph.json` in a `.ua/` data dir; the other skills consume that graph. Optional `--auto-update` regenerates the graph on commit.

The interesting non-code capability: `/understand-knowledge` graphs a Karpathy-pattern markdown wiki (entity extraction + implicit relationships) — the only piece pointed at knowledge bases rather than codebases.

### Where it sits in my system

**Parked-tooling category, not skill category** — the same shelf as codebase-memory-mcp (DeusData), and its direct competitor for the same job: structural codebase knowledge for agents. Comparison:

| | Understand-Anything | codebase-memory-mcp |
|---|---|---|
| Mechanism | plugin: skills + scripts + local dashboard | MCP server: 15 query tools |
| Consumption | human-facing dashboard + `/understand-chat` Q&A | agent-facing structural queries (trace_path, Cypher) |
| Auditability | high — skills and scripts are readable files | lower — server binary behavior |
| Repo footprint | writes `.ua/` (+ optional commit hook) | installer auto-writes agent configs (the ⚠ that parked it) |
| Token economy | graph pre-built, agents read JSON slices | queries replace grep — same philosophy |

**Overlaps in the existing catalog:** Matt's `/improve-codebase-architecture` (codebase scan → visual HTML report) covers part of the human-facing value; Scenario 2 (returning to an old repo) is exactly its pitch. It does *not* overlap the review lanes or the pipeline proper — `understand-diff` is closest to review territory but is impact-analysis, not judgment.

### Quick security read (pre-audit, not the audit)

- No network calls inside skill scripts (grep clean) — analysis is local.
- Install path is `curl | bash` (or plugin marketplace) — **never that route**; if trialed, clone + audited local install only, per the audit-first rule.
- `--auto-update` writes a git commit hook — must coexist with the git-guardrails PreToolUse hook (different mechanisms, expected compatible, verify in trial).
- Writes only `.ua/` in the target repo — no `docs/adr/` conflict (the issue that gates codebase-memory-mcp).
- 858-line main SKILL.md — fine for a plugin, but confirms this is infrastructure, not something to absorb into `skills/`.
### Verdict

**PARK, positioned as the codebase-memory-mcp alternative.** When the "structural codebase memory" trial actually happens (post-deployment queue), evaluate the two head-to-head on one personal repo; Understand-Anything is currently the stronger candidate on auditability and the non-conflicting data dir. Trial protocol when it comes: clone, audit install.sh + the extraction scripts line-by-line, local install without marketplace, `--no-auto-update` first run, `--private`-style exclusion of `.ua/` if the repo is shared. If adopted, the enrichment hook is the same one flagged for the MCP: pipeline skills could prefer graph queries over grep — complement material, never edits to vendored skills.

**No action now.** *(Updated 2026-08-04: the deployment queue that used to stand in front of this — claude.ai uploads, Laptop B, hooks, the 🧪→✅ sweep — is closed. Uploads landed, the sweep ran, and machine currency became a runbook rather than a queue item. This doc is no longer blocked by Phase 1.5; it is blocked only by whether the work is worth doing.)*

---

## 3. Sequencing (both repos)

1. ~~Finish the Phase 1.5 deployment queue.~~ **Closed 2026-08-04** — no longer gates anything below.
2. Superpowers gap audits, in order: verification-before-completion → receiving-code-review → finishing-a-development-branch.
3. Superpowers comparison reads (tdd, systematic-debugging) — opportunistic, notes only.
4. Understand-Anything vs codebase-memory-mcp head-to-head — when the parked-tooling trial unparks.
5. dispatching-parallel-agents / subagent-driven-development — read when graph engineering unparks
