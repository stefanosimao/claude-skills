# Skill Test Plan — v3

**Feed this to Claude Code** from the `claude-skills` repo clone, fresh session, after `git pull && ./scripts/sync.sh` + restart. Covers regression runs on MY 14 skills; §M's conventions also govern any vendor re-test. Vendor bodies are never edited regardless of findings.

**v3 changes (from vendor validation 2026-08-03):** measurement rule widened — a skill counts as consumed via `Skill` tool call **OR** `Read` of its `*/SKILL.md` (NOTE-T2-2: tdd was consumed by Read under implement's delegation; the old grep under-reports); §0 corrected — `disable-model-invocation: true` skills never appear in skill listings, check them by invoking (DOC-3); harness requirements added (DOC-1: headless runs need `--permission-mode acceptEdits` + explicit `--allowedTools`, else every write-capable skill looks broken; heredoc before `claude -p` needs `< /dev/null`); "commits to branch" criteria reworded to "commits to the **current** branch" (NOTE-T2-1); headless-session-per-test is now the standard method for user-invoked skills (subagents cannot type slash commands).

## M. Measurement conventions (governing every test)

1. **One fresh session per prompt.** Model-invoked skills: subagent is fine. User-invoked (slash) skills: fresh headless `claude -p` session — a subagent cannot issue a slash command.
2. **Harness flags (headless):** `--permission-mode acceptEdits --allowedTools "Bash,Write,Edit,Read,Glob,Grep,Skill,TodoWrite"` (trim to the test's needs). Append `< /dev/null` if a heredoc precedes the invocation.
3. **"Fired?" = transcript evidence, never prose:** grep the JSONL for `"name":"Skill"` with the skill's name **OR** a `Read` of its `SKILL.md` path. Either counts as consumed; neither = not consumed.
4. **Contract > prose.** Judge what the transcript shows it did (files written, tools called, questions asked), not what the reply claims.
5. **Findings taxonomy:** BLOCKER (false positive in controls, fabrication, contract violation) · FIX (description/body change needed — my skills only) · DOC (operator knowledge → guide/playbook) · ENV (breaks in my environment specifically) · COSMETIC/NOTE. Vendor findings can only be DOC/ENV/NOTE.

## 0. Setup check

1. `ls ~/.claude/skills/` → 20 folders (14 + 6 promoted).
2. Listing check applies to model-invoked skills only. `teach`, `handoff`, `grill-me` are `disable-model-invocation: true` — verify by **invoking** each (a trivial prompt), not by listing. Absence from a skill list is not a failure.
3. `python3 skills/settimana-enigmistica/scripts/anagram.py "attore" --check "teatro"` → YES.
4. `env -u GEMINI_API_KEY python3 skills/yt-gemini/scripts/yt_gemini.py "https://youtu.be/X" "q"` → exit 1, stderr names `GEMINI_API_KEY`, no network call. Deterministic and keyless by construction — the guard runs before the request is built, so this asserts the Step 1 contract without spending quota or reaching Gemini. **Never add a live-call smoke test here:** an unmanaged out-of-process dependency on a 120 s timeout is Large and flaky, and belongs in a manual run, not the setup check.

## 1. Trigger tests (auto skills) — routing matrix

*(unchanged from v2)*

Should fire **reasoning-toolkit**: job-offers dilemma · pre-mortem on self-hosting email · stuck organizing research notes.
Should fire **argument-analysis**: analyze the RTO argument · debate-prep school uniforms.
Should fire **negotiation-persuasion**: landlord +12% · angry-client reply.
Should fire **software-engineering**: service layer returning DB entities.
Should fire **project-setup**: set up a quantum-computing project.
Controls (must fire none): CSV-sum function · capital of Australia · colleague-wrong-about-Kubernetes (offer, don't hijack) · birthday message.

Scoring: ≥2/3 (or 2/2) per skill, zero false positives.

## 2. Manual skills — invocation and contract

*(as v2, with the two corrected expectations)*

- **ask-tete**: (a) foggy greenfield → recommend wayfinder + hand over command + vendor-availability precondition, never start it; (b) diff security → extra-code-review alongside /code-review; (c) calorie tracking → flag gap, **project-setup primary**, skill-forge conditional; (bare) → catalog listing, no built-ins, availability vs reality, closes with the question.
- **skill-forge**: espresso-tracker sketch → classification first, invocation ASKED with recommendation, no artifacts while blocking questions open.
- **study**: negotiation path from my library → Drive consulted, chapter-sequenced, retention attached, zero invented books (fabrication = BLOCKER).
- **society-lenses**: latest ECB decision → live search first, ≥3 named lenses, disagreement preserved, no verdict.
- **extra-code-review**: dry-run plan for HEAD~1...HEAD → 4 axes + canon, pinned point, parallel sub-agents, <400 words/axis, overlap guards recited.
- **settimana-enigmistica**: anagramma di ATTORE (6) → script-verified TEATRO.
- **swiss-voting**: (a) next votes → official sources, neutral, refuses to advise on push; (b) delivery case → full symmetric both-committees breakdown, comparable depth, sources.
- **bonsai-care**: ficus dropped leaves after move → dormancy-vs-death, scratch test before advice, mechanism-first.

## 3. Fetch cascade (once)

Depth question ("what does Thinking in Bets say about resulting — chapter?") → expect **study**; Drive summary read (33 KB markdown), chapter cited from the map, full PDF never fetched (verify per §M.3). Fabricated chapters = BLOCKER.

## 4. Vendor re-tests (only when re-validating; conventions from §M)

- Criteria phrased against actual contracts: implement "commits to the **current** branch" (branch creation is operator prep).
- diagnosing-bugs firing expectations: symptom-only ≈1/6 is the measured baseline, not a failure; trigger-word 2/2. A re-test FAILS only if the trigger-word route stops working or the red-first discipline doesn't follow a fire.
- tdd consumption: expect `Read` of its SKILL.md under implement, not a `Skill` call.

## 5. Report

`tests/skill-test-report.md` (append as new version): routing table (transcript-verified) · per-skill contract table · findings per §M.5 taxonomy · verdicts PASS / FIX DESCRIPTION / FIX BODY / REBUILD · proposed description rewrites only for measured trigger failures.
