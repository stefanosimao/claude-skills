# Skill Test Plan — v1 (post-build verification)

> ⛔ **SUPERSEDED BY [v3](skill-test-plan-v3.md). Do not run this plan.**
> Kept as the record of what was actually tested on 2026-07-28, when the catalog held 13 skills. **Its numbers are accurate as history and wrong as instruction** — §0 asks you to confirm 13 skills and calls a shortfall a BLOCKER, so running it today raises a false BLOCKER on the first step against a 14-skill catalog. The count is deliberately left at 13: correcting it would falsify what this run measured. **General rule for a document that is both record and instruction: mark its status, don't rewrite its content.**

**Feed this to Claude Code** from inside the `claude-skills` repo clone, in a FRESH session, after `git pull && ./scripts/sync.sh` and a restart (so the synced skills are actually loaded). Test only — fix nothing without reporting first. The skills under test are the 13 in `skills/`; the vendor layer is out of scope (verbatim, already audited).

## 0. Setup check

1. Confirm all 13 skills appear in your available skills (`/context` or ask yourself). Missing skills = BLOCKER, stop and report.
2. Confirm `python3 skills/settimana-enigmistica/scripts/anagram.py "attore" --check "teatro"` prints YES.

## 1. Trigger tests (auto skills) — the routing matrix

For each prompt below, spawn a FRESH Task subagent whose only instruction is the prompt verbatim (no hints), then inspect which skill(s) it invoked. Record: fired / didn't fire / wrong skill fired. One subagent per prompt — never reuse context.

**Should fire reasoning-toolkit:**
- "I got two job offers, one safe and one risky startup. Help me think through which to take."
- "Run a pre-mortem on my plan to self-host our email server."
- "I'm completely stuck on how to organize my research notes, I keep going in circles."

**Should fire argument-analysis:**
- "Analyze this argument: 'Remote work must hurt productivity, because the most successful companies are forcing people back to the office.'"
- "Prep me to debate school uniforms, I'm against them."

**Should fire negotiation-persuasion:**
- "My landlord wants to raise rent 12%. Help me prepare the conversation."
- "Draft a reply to a client who's angry about a delayed delivery — the relationship matters."

**Should fire software-engineering:**
- "Is it good practice to have my service layer return database entities directly to the controller? What would the references say?"

**Should fire project-setup:**
- "I want to set up a Claude project for learning quantum computing — how should I structure it?"

**Should NOT fire any of my autos (control group):**
- "Write a Python function that parses a CSV and sums column 3." (no skill, or tdd at most)
- "What's the capital of Australia?"
- "My colleague is wrong about Kubernetes and it's annoying." (argument-analysis must NOT fire — no explicit analysis request)
- "Write a nice birthday message for my mother." (negotiation-persuasion must NOT fire — no stakes)

Scoring: an auto skill passes with ≥2/3 (or 2/2) of its should-fire prompts firing AND zero false positives in the control group. One false positive = FIX (description too pushy); systematic misses = FIX (too narrow).

## 2. Manual skills — invocation and contract

Invoke each by name in a fresh subagent and check the CONTRACT, not the prose:

- **ask-tete** — three scenarios: (a) "ask tete: I have a huge foggy greenfield project idea" → must recommend wayfinder AND hand over the command for a fresh session, NOT start it; (b) "ask tete: I want to check my diff for security issues" → extra-code-review (alongside /code-review); (c) "ask tete: I want to track my calories" → must flag the gap and offer skill-forge, not improvise.
- **skill-forge** — "use skill-forge to sketch a skill for tracking my espresso recipes" → must run intent capture and the Skill-vs-Project check BEFORE drafting; must ask about invocation mode; must NOT skip to a finished skill.
- **study** — "use study to build me a path into negotiation from my library" → must consult Drive `_sources.md`/`_summaries` (negotiation-persuasion folder), sequence chapters not books, attach retention. If it invents books not in the library = BLOCKER (fabrication).
- **society-lenses** — "use society-lenses on the latest ECB rate decision" → must web-search the event first, apply ≥3 NAMED lenses, present disagreement, no personal verdict.
- **extra-code-review** — dry-run contract check only (no real repo): ask it to describe its plan for reviewing HEAD~1...HEAD → must name the 4 axes, pinned fixed point, parallel sub-agents, <400 words/axis, and refuse Fowler smells/spec conformance (overlap guards).
- **settimana-enigmistica** — "risolvi: anagramma di ATTORE (6)" → must use the script to verify, answer TEATRO (or equivalent verified).
- **swiss-voting** — "use swiss-voting: what are we voting on next?" → must hit admin.ch/easyvote live, present both committees symmetrically, refuse to advise a vote if pushed ("how should I vote?" follow-up).
- **bonsai-care** — "use bonsai-care: my ficus dropped all its leaves after I moved it" → must run the diagnostic framework (dormancy-vs-death, scratch test before advice), mechanism-first.

## 3. Fetch cascade (end-to-end, once)

In one subagent with Drive MCP available: trigger reasoning-toolkit with a depth question ("what does Thinking in Bets actually say about resulting — chapter please"). PASS = it searches Drive for the `thinking-in-bets` summary, cites the chapter from the map, and does NOT fetch the full book. Fabricated chapter numbers = BLOCKER.

## 4. Report

Write `skill-test-report.md` in the repo root:
- Routing matrix table: prompt / expected / observed / verdict
- Per-skill table: trigger ✓/✗ · contract ✓/✗ · notes
- Findings tagged **BLOCKER** (false positives in control group, fabrication, contract violations like ask-tete launching an orchestrator) or **FIX** (trigger tuning, prose issues) or **COSMETIC**
- Verdict per skill: **PASS** / **FIX DESCRIPTION** / **FIX BODY** / **REBUILD**
- Proposed description rewrites for any trigger failures (Workflow A step 5 material) — propose only, change nothing.

Costs note: ~20 subagents total; keep each minimal (the prompt, nothing else). Stop and report after each section if anything looks systematically broken.
