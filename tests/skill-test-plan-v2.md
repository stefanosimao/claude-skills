# Skill Test Plan — v2 (post-first-run maintenance)

**Feed this to Claude Code** from inside the `claude-skills` repo clone, in a FRESH session, after `git pull && ./scripts/sync.sh` and a restart (so the synced skills are actually loaded). Test only — fix nothing without reporting first. The skills under test are the 13 in `skills/`; the vendor layer is out of scope (verbatim, already audited).

**v2 changes (from test report v1):** §3 expectation corrected to `study` (NOTE-1); ask-tete (c) expectation corrected to project-setup-primary (NOTE-2); swiss-voting gains a delivery sub-case for the symmetric both-committees contract; measurement method standardized — skill firing is verified by grepping each subagent's JSONL transcript for `Skill` tool calls, never inferred from prose.

## 0. Setup check

1. Confirm all 13 skills appear in your available skills (`/context` or ask yourself). Missing skills = BLOCKER, stop and report.
2. Confirm `python3 skills/settimana-enigmistica/scripts/anagram.py "attore" --check "teatro"` prints YES.

## Measurement method (standard for every test below)

One fresh Task subagent per prompt, given the prompt **verbatim and nothing else**. After each run, grep the subagent's JSONL transcript for `"name":"Skill"` tool calls — "did it fire?" is an observation, never an inference from prose. Record: fired / didn't fire / wrong skill fired.

## 1. Trigger tests (auto skills) — the routing matrix

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
- "My colleague is wrong about Kubernetes and it's annoying." (argument-analysis must NOT fire — no explicit analysis request; offering skills and asking is the desired behavior)
- "Write a nice birthday message for my mother." (negotiation-persuasion must NOT fire — no stakes)

Scoring: an auto skill passes with ≥2/3 (or 2/2) of its should-fire prompts firing AND zero false positives in the control group. One false positive = FIX (description too pushy); systematic misses = FIX (too narrow).

## 2. Manual skills — invocation and contract

Invoke each by name in a fresh subagent and check the CONTRACT, not the prose:

- **ask-tete** — three scenarios: (a) "ask tete: I have a huge foggy greenfield project idea" → must recommend wayfinder AND hand over the command for a fresh session, NOT start it; (b) "ask tete: I want to check my diff for security issues" → extra-code-review (alongside /code-review); (c) "ask tete: I want to track my calories" → must flag the gap and refuse to improvise; **expected primary route = project-setup** (data accumulates daily → project), with skill-forge as the conditional handover if the user wants method rather than log. Either component missing = FIX.
- **skill-forge** — "use skill-forge to sketch a skill for tracking my espresso recipes" → must run intent capture and the Skill-vs-Project check BEFORE drafting; **must ASK the invocation-mode question with a recommendation attached (confirm-or-override), never decide it unilaterally**; must NOT emit SKILL.md/reference files while its own blocking intake questions are open (outline-only is acceptable for a "sketch" request).
- **study** — "use study to build me a path into negotiation from my library" → must consult Drive `_sources.md`/`_summaries` (negotiation-persuasion folder), sequence chapters not books, attach retention. If it invents books not in the library = BLOCKER (fabrication).
- **society-lenses** — "use society-lenses on the latest ECB rate decision" → must web-search the event first, apply ≥3 NAMED lenses, present disagreement, no personal verdict.
- **extra-code-review** — dry-run contract check only (no real repo): ask it to describe its plan for reviewing HEAD~1...HEAD → must name the 4 axes, pinned fixed point, parallel sub-agents, <400 words/axis, and refuse Fowler smells/spec conformance (overlap guards).
- **settimana-enigmistica** — "risolvi: anagramma di ATTORE (6)" → must use the script to verify, answer TEATRO (or equivalent verified).
- **swiss-voting** — two sub-cases:
  - (a) "use swiss-voting: what are we voting on next?" → must hit admin.ch/easyvote live; neutral overview; refuse to advise a vote on the pushed follow-up ("how should I vote?").
  - (b) **delivery case (new in v2):** "use swiss-voting: give me both committees' arguments on [the next federal vote] — full breakdown." → must DELIVER the symmetric both-sides breakdown (not just offer it): comparable depth per side, sources cited, no editorial lean detectable in framing or ordering.
- **bonsai-care** — "use bonsai-care: my ficus dropped all its leaves after I moved it" → must run the diagnostic framework (dormancy-vs-death, scratch test before advice), mechanism-first.

## 3. Fetch cascade (end-to-end, once)

In one subagent with Drive MCP available: ask a depth question ("what does Thinking in Bets actually say about resulting — chapter please"). **Expected skill: `study`** (librarian work — "what does book X say"; corrected from v1's reasoning-toolkit prediction). PASS = it searches Drive for the `thinking-in-bets` summary, cites the chapter from the map, and does NOT fetch the full book. Fabricated chapter numbers = BLOCKER. Verify the no-full-book claim from the transcript (`read_file_content` on the summary's markdown only).

## 4. Report

Write `skill-test-report.md` in the repo root (append as a new version if one exists):
- Routing matrix table: prompt / expected / observed (transcript-verified) / verdict
- Per-skill table: trigger ✓/✗ · contract ✓/✗ · notes
- Findings tagged **BLOCKER** (false positives in control group, fabrication, contract violations like ask-tete launching an orchestrator) or **FIX** (trigger tuning, prose issues) or **COSMETIC**
- Verdict per skill: **PASS** / **FIX DESCRIPTION** / **FIX BODY** / **REBUILD**
- Proposed description rewrites for any trigger failures (Workflow A step 5 material) — propose only, change nothing.

Costs note: ~25 subagents total; keep each minimal (the prompt, nothing else). Stop and report after each section if anything looks systematically broken.
