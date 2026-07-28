# claude-skills
 
Source of truth for my Claude Skills. Designed in the **Skills Hub** claude.ai project; distributed from here to every surface. Two layers: **my skills** in `skills/` (synced to the personal budget), and **Matt Pocock's engineering pipeline** in `vendor/mattpocock/` (verbatim, version-pinned @ `ed37663`; scope is per-skill — six promoted to personal scope, the other 16 repo-scoped).
 
## Layout
 
```
claude-skills/
├── catalog.md              ← living inventory: status, version, invocation, enabled-where
├── skills/                 ← my 13 skills (one folder each: SKILL.md + references/ + scripts/)
├── vendor/
│   ├── mattpocock/         ← 22 vendored skills + VENDOR-PIN.md (checksums, scope rule)
│   └── audits/             ← one read-understand-gap audit per vendored skill
├── scripts/
│   ├── sync.sh             ← skills/ + promoted vendor skills → ~/.claude/skills/  (--link for symlink mode)
│   ├── install-vendor.sh   ← the pinned Matt set → a repo's .claude/skills/  (--private to git-exclude)
│   └── package.sh          ← zip skills into dist/ for claude.ai upload
└── templates/              ← SKILL.md + project-setup templates
```
 
## Install — fresh machine (Claude Code)
 
```bash
git clone https://github.com/stefanosimao/claude-skills.git
cd claude-skills
./scripts/sync.sh            # installs skills/ → ~/.claude/skills/
```
Verify: ask Claude Code "which skills do you have?" — the 13 below should appear. Update later with `git pull && ./scripts/sync.sh`. Single skill: `npx skills add stefanosimao/claude-skills@<skill-name>` (private repo may need auth; clone+sync always works).
 
## Install — claude.ai (web / mobile / desktop)
 
Preferred: click **Save skill** when Claude presents a packaged `.skill`. Otherwise `./scripts/package.sh <name>` → Settings → Capabilities → Upload skill (delete the old version first when updating) → toggle **on**. Enabling on claude.ai automatically covers cloud sessions, Cowork, and routines. Enable deliberately per the catalog's enabled-where column — not everything everywhere.
 
## Install — Matt pipeline into a repo
 
```bash
./scripts/install-vendor.sh <repo>              # shared: commit the skills — team + cloud sessions get them
./scripts/install-vendor.sh --private <repo>    # laptop-only: git-excluded, never reaches the remote (no cloud)
```
Installs the whole pinned set (partial installs refused — skills detect each other; every `SKILL.md` is checksum-verified against `VENDOR-PIN.md` first). Then run `/setup-matt-pocock-skills` **once in that repo** — it configures the issue tracker (GitHub / GitLab / local-markdown — local needs no CLI at all), triage labels, and doc layout. Note: `triage` posts public AI-disclaimed comments — check that's acceptable on work repos. Repo-scoped skills win on name clash and cost zero personal context budget.

Six skills (`teach`, `handoff`, `grilling`, `grill-me`, `resolving-merge-conflicts`, `diagnosing-bugs`) are also promoted to personal scope via `sync.sh`'s `PROMOTED_VENDOR` list — you don't need this script just for those (catalog Decision 30).
 
## The skills
 
### Meta
| Skill | Invocation | What it does |
|---|---|---|
| **ask-tete** | manual | Catalog concierge: given a situation, recommends the fitting skill/flow (Matt's + mine), follows disciplines directly on confirm, hands over commands for orchestrators (fresh session), flags gaps → skill-forge. Start here when unsure. |
| **skill-forge** | manual | Builds/improves/imports skills my way: intent → invocation choice → draft → test → package, with house conventions (leading words, <500 lines, hooks-over-prose, catalog discipline). |
| **project-setup** | auto (narrow) | Stands up a new Claude project: Skill-vs-Project-vs-Hybrid framework first, then instructions, knowledge docs, Drive wiring, end-to-end fetch test. |
 
### Thinking & learning (book-grounded, fetch cascade to Drive)
| Skill | Invocation | What it does |
|---|---|---|
| **reasoning-toolkit** | auto (narrow) | Decisions AND stuckness: selects 1–3 tools (mental models, inversion, base rates, pre-mortems, decomposition, reframing) and applies them to your specifics. |
| **argument-analysis** | auto | Maps argument structure, rates evidence, names fallacies with mechanisms, always steelmans; debate-prep mode. Fires on explicit analysis requests only. |
| **negotiation-persuasion** | auto | Situation→tactic support for negotiations and difficult conversations (tactical empathy, influence principles, safety moves); strategy-labeled drafts. Integrity guardrail: influence, not manipulation. |
| **society-lenses** | manual | Interprets events/policies through ≥3 named lenses (incentives, geography, cycles, tech-and-power); competing schools kept competing; pairs with live web search. |
| **study** | manual | Librarian/curriculum over MY library: chapter-level learning paths from the summaries, teach-now mode, retention practice (retrieval, spacing, interleaving). Hands interactive courses to /teach. |
 
### Programming — Layer 2 (complements, never replacements)
| Skill | Invocation | What it does |
|---|---|---|
| **software-engineering** | auto (narrow) + callable | Canon consultant at any pipeline stage: design/testing/data/legacy questions answered with book+chapter citations; defers to /codebase-design vocabulary inside the pipeline. |
| **extra-code-review** | manual | The 4 axes /code-review doesn't do — security, defects, performance, tests — same skeleton (pinned diff, parallel sub-agents, <400 words, no reranking), run alongside. |
 
### Personal
| Skill | Invocation | What it does |
|---|---|---|
| **bonsai-care** | manual | Species-aware diagnosis and care (dormancy-vs-death, scratch test, root inspection); Ficus-deep; trusted-source verification. |
| **settimana-enigmistica** | manual | Italian puzzle methods: rebus reading conventions, letter-arithmetic games with a verification script, crittografie double-reading, cruciverba, indovinelli. claude.ai-primary. |
| **swiss-voting** | manual | Vote research from official sources (admin.ch, easyvote), both committees presented neutrally, Aargau context; live-web only, never advises a vote. claude.ai-primary. |
 
### Layer 1 — Matt Pocock's engineering pipeline (`vendor/mattpocock/`, verbatim, pinned @ ed37663)
 
The vendored 7-phase workflow: **Idea → Research → Prototype → PRD → Kanban → Execution → QA**, plus cross-cutting disciplines. *User* = you type the command (orchestrators, zero context cost); *model* = fires on its own when relevant (disciplines). Per-skill audits in `vendor/audits/`; never edited, updates only via re-audit + pin bump.
 
**Precondition (once per repo)**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| setup-matt-pocock-skills | user | Teaches one repo how the pipeline behaves there: writes `docs/agents/` config (issue tracker: GitHub/GitLab/**local-markdown — zero external deps**/other; triage label mapping; CONTEXT.md+ADR layout) + an Agent-skills block in CLAUDE.md. Explore→present→confirm→write. | Once, before any other engineering skill in a repo. If to-spec/triage start guessing where issues live, this hasn't run. |
 
**Phase 1 — Idea (sharpen before building)**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| grilling | model | The interview engine: relentless one-question-at-a-time interrogation, recommended answer per question, walks the decision tree, looks up facts itself (only *decisions* go to you), acts on nothing until shared understanding. | You say "grill me" or want a plan stress-tested; the two skills below run it. |
| grill-me | user | Wrapper: run a /grilling session, stateless — saves nothing. | Sharpening any plan/design **outside a codebase**. |
| grill-with-docs | user | Wrapper: /grilling + /domain-modeling — the interview that leaves a paper trail (CONTEXT.md terms, ADRs) as decisions land. | Sharpening an idea **inside a codebase** — the main flow's step 1. |
 
**Phase 2 — Research (optional: cache external knowledge)**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| research | model | Fires a background agent to investigate a question against PRIMARY sources (official docs, source code, specs), writing one cited markdown file into the repo — a sprint-lifetime asset. | The idea involves external APIs/docs; delegate the reading and keep working. Feeds back into grilling. |
 
**Phase 3 — Prototype (optional: impose taste before committing)**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| prototype | model | Throwaway code answering ONE question — logic branch (tiny terminal app driving the state machine) or UI branch (radical variants switchable by URL param). In-memory, unpolished, one command to run; validated decision folds into real code, prototype dies on a throwaway branch. | "Does this state model feel right?" / "What should this look like?" can't be settled on paper. Bridge via /handoff in and out. |
 
**Phase 4 — PRD**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| to-spec | user | Synthesizes the CURRENT conversation into a spec (no interview): problem, solution, exhaustive user stories, implementation & testing decisions, out-of-scope — test seams agreed FIRST, no file paths (they stale). Publishes to the tracker, ready-for-agent. | The grilling thread has settled the decisions; describe the end state, not the journey. Keep phases 1–4 in ONE context window. |
 
**Phase 5 — Kanban**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| to-tickets | user | Breaks the spec into **tracer-bullet vertical slices** (each cuts schema→API→UI→tests, demoable alone, fits one context window), each declaring its **blocking edges**; quizzes you on granularity before publishing blockers-first. Wide refactors become expand→migrate-batches→contract. | After to-spec, before execution. The blocking graph is what makes agents parallelizable. |
| wayfinder | user | The heaviest orchestrator, for efforts **too big for one session**: charts a shared MAP issue + child **decision tickets** (research/prototype/grilling/task types), works the frontier one ticket per session, fog-of-war sections for what's not yet specifiable. Produces **decisions, not deliverables**; when the way is clear, hands off to to-spec. | Huge foggy greenfield efforts. Never for a well-scoped feature — it's slower and denser by design. |
 
**Phase 6 — Execution**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| implement | user | The executor glue: build from spec/ticket, driving /tdd at pre-agreed seams, typecheck+tests as it goes, /code-review at the end, commit to the branch. | Per ticket, in a FRESH session each (the tickets carry the context). AFK-capable when phases 2–5 assets exist. |
| tdd | model | The red→green discipline: tests only at pre-agreed seams, behavior through public interfaces, anti-patterns named (implementation-coupled, tautological, horizontal slicing), refactoring belongs to review not the loop. | Building test-first, with or without a full spec; implement drives it internally. |
| handoff | user | Compacts the conversation into a handoff doc (OS temp dir, secrets redacted, artifacts referenced not duplicated, suggested-skills section) for a fresh session to pick up. | The window nears degradation mid-flow, or you branch into a prototype session. /handoff forks; /compact continues. |
 
**Phase 7 — QA**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| triage | user | State machine over tracker items (bug/enhancement × needs-triage/needs-info/ready-for-agent/ready-for-human/wontfix): verifies claims by reproducing, checks redundancy against the codebase and prior rejections (.out-of-scope/ KB), grills fuzzy requests into shape, writes durable agent briefs. AI-disclaimer on every public comment. | Issues/PRs **you didn't create** pile up. Never for to-tickets output — that's already agent-ready. |
| code-review | user | Two-axis diff review vs a pinned fixed point, parallel sub-agents, reports never merged: **Standards** (repo docs + 12 Fowler smells baseline) and **Spec** (diff vs originating issue: missing/partial/scope-creep/implemented-but-wrong). <400 words/axis. | Reviewing any branch/PR; implement runs it automatically. Pair with my /extra-code-review for the four axes it skips. |
 
**Cross-cutting disciplines**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| codebase-design | model | The design VOCABULARY: module/interface/depth/seam/adapter/leverage/locality, deep-vs-shallow, the deletion test, "the interface is the test surface", design-it-twice via parallel sub-agents. | Designing or reshaping a module's interface; other skills speak this language. |
| domain-modeling | model | The ACTIVE glossary/ADR discipline: challenges terms against CONTEXT.md, sharpens fuzzy language with edge-case scenarios, cross-references claims vs code, updates the glossary inline, offers ADRs only when hard-to-reverse + surprising + real trade-off. | Domain language is being created or changed (grill-with-docs drives it). |
| improve-codebase-architecture | user | Codebase-wide deepening scan weighted to git-history hot spots; presents candidates as a visual HTML report (before/after diagrams, Strong/Worth-exploring/Speculative), then grills through your pick. | Spare-moment upkeep: keeping the codebase good for agents to navigate. Output feeds the main flow as a new idea. |
| diagnosing-bugs | model | The 6-phase diagnosis loop whose heart is Phase 1: build a **tight, red-capable** feedback loop (one command that goes red on THIS bug) before any theorizing; then reproduce+minimise, 3–5 falsifiable hypotheses, one-variable instrumentation, regression-test-before-fix, cleanup+post-mortem. | Hard bugs, flakes, perf regressions that resist a first glance. Post-mortem hands architectural causes to improve-codebase-architecture. |
 
**Utilities & extras**
 
| Skill | Invoke | What it does | Reach for it when |
|---|---|---|---|
| resolving-merge-conflicts | model | Conflict procedure: understand both intents from primary sources (commits, PRs, tickets), preserve both where possible, never invent behavior, never --abort, run the project's checks, finish the merge/rebase. | Mid-merge/rebase with conflicts. |
| git-guardrails-claude-code | model | Installs a PreToolUse hook blocking dangerous git (push, reset --hard, clean -f, branch -D, checkout .) — deterministic enforcement, the hooks-over-prose exemplar. | You want destructive git ops impossible, not discouraged. Project or global scope. |
| setup-pre-commit | user | One-time pre-commit hook wiring per the repo's toolchain. | Setting up a repo's commit checks. |
| teach | user | Stateful multi-session teaching workspace in the current directory: MISSION.md grounds everything, short ZPD-scoped HTML lessons, durable reference docs, learning records, retention via desirable difficulty. | Learning a topic interactively over multiple sessions. My `study` skill builds paths from my library and hands interactive courses here. |
 
**Excluded from the vendor layer:** ask-matt (superseded by my ask-tete) · writing-great-skills (principles absorbed into skill-forge's references) · scaffold-exercises, migrate-to-shoehorn (his course tooling) · deprecated/, in-progress/, personal/. **Removed from my catalog:** interview-answer-coach (full rebuild planned via skill-forge).
 
## Rules
 
- Skill work starts and ends in the Skills Hub project; this repo holds the files.
- Matt's skills stay VERBATIM; my complements live alongside (`extra-*` naming), obeying his invocation rules (orchestrators never invoke orchestrators).
- Third-party skills are never installed unaudited: clone → line-by-line review → adapt → only then enter this repo.
- Book-grounded skills fetch depth from Google Drive `Skill-Library/<folder>/_summaries/` by filename search (folder browsing doesn't work; verify by content, never modifiedTime).
- After any change: bump version in `catalog.md`, tick enabled-where, propagate (push → sync laptops → claude.ai re-save).
