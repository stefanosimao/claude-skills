# claude-skills

Source of truth for my Claude Skills. Designed in the **Skills Hub** claude.ai project; distributed from here to every surface. Two layers: **my skills** in `skills/` (synced to the personal budget), and **Matt Pocock's engineering pipeline** in `vendor/mattpocock/` (verbatim, version-pinned @ `ed37663`, repo-scoped only — never synced account-wide).

## Layout

```
claude-skills/
├── catalog.md              ← living inventory: status, version, invocation, enabled-where
├── skills/                 ← my 13 skills (one folder each: SKILL.md + references/ + scripts/)
├── vendor/
│   ├── mattpocock/         ← 22 vendored skills + VENDOR-PIN.md (checksums, scope rule)
│   └── audits/             ← one read-understand-gap audit per vendored skill
├── scripts/
│   ├── sync.sh             ← skills/ → ~/.claude/skills/  (--link for symlink mode)
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

## Install — Matt pipeline into a work repo

```bash
cp -r vendor/mattpocock/* <work-repo>/.claude/skills/     # copy the SET together (skills detect each other)
```
Then run `/setup-matt-pocock-skills` **once in that repo** before any pipeline skill — it configures the issue tracker (GitHub / GitLab / local-markdown — local needs no CLI at all), triage labels, and doc layout. Repo-scoped skills win on name clash and cost zero personal context budget.

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

### Layer 1 — Matt Pocock, vendored verbatim (`vendor/mattpocock/`, pinned @ ed37663)
The 7-phase engineering pipeline: grilling/grill-me/grill-with-docs (interview) · research · prototype · to-spec/to-tickets (PRD→tickets) · wayfinder (huge efforts) · implement/tdd/handoff (build) · triage/code-review (QA) · codebase-design/domain-modeling/improve-codebase-architecture/diagnosing-bugs (cross-cutting) · teach · setup-matt-pocock-skills (per-repo config) · resolving-merge-conflicts/git-guardrails/setup-pre-commit (utilities). Per-skill audits in `vendor/audits/`. Never edited; updates only via re-audit + pin bump. Removed/parked: interview-answer-coach (full rebuild planned via skill-forge).

## Rules

- Skill work starts and ends in the Skills Hub project; this repo holds the files.
- Matt's skills stay VERBATIM; my complements live alongside (`extra-*` naming), obeying his invocation rules (orchestrators never invoke orchestrators).
- Third-party skills are never installed unaudited: clone → line-by-line review → adapt → only then enter this repo.
- Book-grounded skills fetch depth from Google Drive `Skill-Library/<folder>/_summaries/` by filename search (folder browsing doesn't work; verify by content, never modifiedTime).
- After any change: bump version in `catalog.md`, tick enabled-where, propagate (push → sync laptops → claude.ai re-save).
