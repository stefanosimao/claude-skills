# Vendor Layer Test Report — Tier 2 (pipeline in a sandbox repo)

Run: 2026-08-03 · sandbox `~/scratch/pipeline-test` · vendor set installed from `claude-skills` @ `3c65347` · companion to `vendor-test-report.md` (Tier 1).

Method as Tier 1: one headless `claude -p` session per step, `--permission-mode acceptEdits` plus an explicit `--allowedTools` list, firing verified by grepping each run's JSONL for `"name":"Skill"`. Multi-turn steps use `--resume` on the same session id, which is how the "no re-interview" and "same conversation" criteria are tested honestly.

**Operator answers in the interviews (2.1, 2.2, 2.4) were written by me, not by Stefano.** They are plausible and internally consistent, but the feature is invented and the preferences are not his. Contract behaviour is the measurable part; taste is not.

## Setup

Seed project committed at `2885b45`: `wcstat`, a CLI reporting line/word/char counts — `wcstat/core.py` (frozen `Counts` dataclass + `count_text`), `wcstat/cli.py` (argparse, one renderer), `tests/test_core.py` (2 tests), README, and a `.venv` with pytest and mypy so "typecheck+tests run" is testable rather than blocked. Both green before the pipeline touched anything.

`install-vendor.sh ~/scratch/pipeline-test` — shared mode, pin verified (22/22 SKILL.md sha256 match `VENDOR-PIN.md`), committed at `31349ab`.

| # | Step | Verdict |
|---|---|---|
| 2.1 | setup-matt-pocock-skills | **PASS** |
| 2.2 | grill-with-docs | **PASS** |
| 2.3 | to-spec | **PASS** |
| 2.4 | to-tickets | **PASS** |
| 2.5 | implement + tdd | **PASS** (one plan-expectation mismatch, see NOTE-T2-1) |
| 2.6 | code-review + extra-code-review | **PASS** |
| 2.7 | triage | **PASS** |
| 2.8 | diagnosing-bugs in-pipeline | **PASS** — overturns DOC-2 mechanism |

---

## 2.1 — setup-matt-pocock-skills · PASS

Session `71f8998e`, four turns.

**Asks before writing — three times, and wrote nothing until told to.** `git status` was empty after every one of the first three turns. It opened with a survey table (no git remote, no `CLAUDE.md`/`AGENTS.md`, no `CONTEXT.md`, no `docs/`, `triage` skill present → "Section B applies", single Python package → "single-context, no question needed"), then asked Section A, then Section B, then showed **drafts of all four files** and asked the one question it refused to decide: `CLAUDE.md` or `AGENTS.md`, "the skill is explicit that this is your call, not mine".

**Local-markdown was its own recommendation, for the right reason** — "there's no git remote at all, so `gh`/`glab` have nothing to talk to". This is the zero-external-deps work-laptop mode validating itself: the skill reached the local tracker by reading the environment, not by being told.

**Written on approval:** `docs/agents/issue-tracker.md` (issues under `.scratch/<feature-slug>/`, `Status:` line, comments convention), `docs/agents/triage-labels.md` (the five canonical roles), `docs/agents/domain.md`, and a new `CLAUDE.md` carrying the `## Agent skills` block. All four criteria met.

**Unprompted and correct:** it flagged that `.scratch/` is *not* in `.gitignore`, so issues will version with the repo — "usually what you want for a local-markdown tracker", with the alternative given. That is the one consequence of local mode a first-time operator would otherwise discover by accident.

## 2.2 — grill-with-docs · PASS

Session `7883a454`, 11 turns. Subject: "add a `--json` output flag to wcstat".

**Interview ran — nine questions, one at a time, each with a recommendation and a reason.** It opened by gathering repo facts rather than asking them (`Counts` shape, `format_counts` as the only renderer, tests cover `core` only, no `CONTEXT.md`, no ADRs). The tree was ordered by cost of reversal, and it said so: Q2 (top-level JSON shape) was flagged as "the one decision here that is genuinely expensive to reverse", and Q1 (who consumes the JSON) as the root the rest hangs off.

Quality of the questioning, since that is what the skill is for:

- **Q3 found the real ambiguity in the domain**, not in the feature: `chars` means codepoints, `wc -c` means bytes, and a grapheme is a third number. "A human reading `chars 5` shrugs; a program that uses it to enforce a length limit is now wrong in a way that only shows up on non-ASCII input."
- **Q7 surfaced a latent bug the feature request never mentioned** — `read_text()` with no encoding means the same file yields different counts under different `LANG`, and cp1252 turns "not text" into a confidently wrong number rather than an error.
- **Q8 caught the trap in the obvious fix** — `ensure_ascii=False` looks nicer but `print()` encodes stdout with the locale's encoding, so an accented *filename* would crash a run that counted fine.
- **Q9 pinned the test seam** (drive `main(argv)` in-process with `tmp_path`/`capsys`), rejecting subprocess with the reason that there is no console script, so it would test an invocation nobody uses.

**Docs — offered only when warranted, which is the criterion.** `CONTEXT.md` was written mid-interview at Q3, the moment a term was demonstrably ambiguous, with Character/Word/Line/Counts. Writing it surfaced two consequences it reported back: `splitlines` counts an unterminated final line so `wcstat` disagrees with `wc -l`, and `Counts` is atomic, which constrained a later question. At the close it proposed **exactly two ADRs** — array-of-one and pinned UTF-8 — with the bar stated explicitly ("a future reader would otherwise look at the code and try to 'fix' it") and named the four decisions that *don't* clear it: flag spelling, renderer placement, `ensure_ascii`, test level. No ADR inflation.

**Held the line on scope:** after writing the ADRs it explicitly did not implement, because "the grilling session runs until you confirm the whole understanding".

## 2.3 — to-spec · PASS

Same session as 2.2, `/to-spec`, 4 turns.

- **Synthesized from the conversation — no re-interview.** Zero questions asked; four turns, all writing.
- **No file paths.** `grep -nE "cli\.py|core\.py|wcstat/|tests/|\.py\b"` over the finished spec: **no matches**, in 13 KB of document.
- **Test seams agreed and carried through** — one seam, the existing CLI entry point driven in-process, with subprocess rejected *in the document* and the reason preserved.
- **Published to the local tracker** at `.scratch/json-output/spec.md` with `Status: ready-for-agent`.
- Vocabulary follows `CONTEXT.md` throughout, and the two decisions most likely to be "fixed" by an implementer are cross-referenced to their ADRs rather than re-argued.

## 2.4 — to-tickets · PASS

Session `28266494` (**fresh** — it worked from the spec file alone, not from the grilling conversation), 2 turns to publish.

**Granularity quiz before publishing — and nothing was written until answered.** It proposed two tickets, then asked three questions with its reasoning already attached: whether the granularity sits right (with the two splits it *declined* to make and why — a docs-only ticket isn't demoable; splitting UTF-8 decoding from error handling would mean writing the same `try`/`except` twice), whether the blocking edge should stand, and whether any prefactoring was wanted (it found none, and said why).

**Vertical tracer-bullet slices.** Ticket 01 is UTF-8 decoding *plus* the clean failure contract *plus* standing up the CLI-seam test file — a demoable behaviour change, not a layer. Ticket 02 is the flag itself. Neither is "add a function" or "write the tests".

**Blocking edges declared** — `Blocked by: None` on 01, `Blocked by: 01` on 02, with the dependency justified rather than asserted (02's failure-path assertions rest on behaviour 01 builds), and the frontier named at the end.

**Tickets in `.scratch/` per local mode**, one file each, `Status: ready-for-agent`, written from the user's perspective with checkbox acceptance criteria, free of file paths and code except the one example JSON record — kept deliberately, because the literal "encodes the key order and the array-of-one shape more precisely than prose could".

## 2.5 — implement + tdd · PASS

Session `87b78580`, **fresh**, 48 turns, $2.49. Ticket 01 only.

**Built from the ticket, and read around it before writing.** Order in the transcript: the ticket → `implement`'s own SKILL.md → repo survey → `cli.py`, `core.py`, `test_core.py` → **ADR-0002** → the spec → `CONTEXT.md` → README → `tdd`'s SKILL.md → `docs/agents/issue-tracker.md` and `triage-labels.md`. It went and got the ADR the ticket cross-referenced rather than working from the ticket text alone.

**Red-green loop visible at the pre-agreed seam.** Baseline suite run first (green), then `tests/test_cli.py` written, then `pytest tests/test_cli.py` (red), then `cli.py` edited, then re-run — that cycle repeats six times through the file, always test-before-code, always at the CLI seam agreed in 2.2 Q9 (`main(argv)` in-process, `capsys`, `tmp_path`). No test reaches into a renderer or internals, exactly as the ticket demanded.

**Typecheck and tests run, repeatedly and at the end.** `.venv/bin/python -m pytest -q && .venv/bin/python -m mypy wcstat tests` — final state 9 passed, mypy clean. It also drove the real CLI by hand over four inputs (good file, missing file, a directory, undecodable bytes) to confirm stream routing and exit codes outside the test harness.

**`code-review` invoked at the end — via a `Skill` tool call**, which then spawned **two parallel sub-agents** (Standards, Spec). Both came back with no hard findings; it acted on one — no test covered the *success* side of the decoding change — and added an accented-text case asserting **17 characters, not the 20 bytes the same text occupies**, which is what makes the encoding pin visible rather than incidental. It declined the other (collapsing the two `except` arms would need an `isinstance` to pick the message) and said why.

**Committed** as `b84df6a`, working tree clean.

### NOTE-T2-1 — "commits to branch" is a plan expectation, not a skill contract

The plan's pass criterion says *commits to branch*; the run committed to `main`. That is **correct behaviour** — `implement/SKILL.md:15` says "Commit your work to the current branch", and my harness never created one. The skill does not branch for you and does not claim to. Operator's guide should say: **create the feature branch before invoking `/implement`**, or accept commits on whatever you're standing on. Test plan v3 should reword the criterion to "commits to the current branch".

### NOTE-T2-2 — Skill-call grep under-reports skills loaded by file read

`tdd` was consumed by **`Read`ing `.claude/skills/tdd/SKILL.md`**, not by a `Skill` tool call — `implement/SKILL.md:9` says "Use /tdd where possible, at pre-agreed seams", and the model satisfied that by pulling the file into context directly. The discipline demonstrably ran (the red-green cycle above), so this is a measurement artefact, not a behaviour gap.

Consequence for the v2/v3 measurement convention: **"fired?" cannot be answered by grepping `"name":"Skill"` alone** when one skill delegates to a sibling. The grep must also catch `Read` of a `*/SKILL.md` path. Worth folding into test plan v3 alongside DOC-1 and DOC-3.

This does not weaken Tier 1's DOC-2 finding: in all four non-firing `diagnosing-bugs` runs there is no `Read` of `diagnosing-bugs/SKILL.md` either — the skill was not consumed by any route.

## 2.6 — code-review + extra-code-review · PASS

Both run against the same fixed point (`f0b3eab...HEAD` = the single commit `b84df6a`), in **separate fresh sessions**, so neither could see the other's output.

- **`/code-review`** (vendor, session from `t26-his`): 8 turns, $1.33, two axes.
- **`/extra-code-review`** (mine, session `8350e241`): 3 turns to pin the fixed point + 10 to run, $1.78 total, four axes.

**Both axis sets ran, and the boundary held in both directions.**

| | Fowler smells | Spec vs the ticket | Security | Defects | Performance | Tests |
|---|---|---|---|---|---|---|
| `/code-review` | ✅ Duplicated Code + Primitive Obsession at `cli.py:22-30` | ✅ 13/13 acceptance criteria | — | — | — | — |
| `/extra-code-review` | **not raised** | **not raised** | ✅ | ✅ | ✅ | ✅ |

**No overlap violations.** `extra-code-review` recited the guard *before* spending agents — unprompted, it warned that it "deliberately skips Fowler smells and spec conformance… That's `/code-review`'s Spec axis. Given this diff ships alongside a ticket file in the same commit, you probably want both runs side by side." Its Performance axis then refused a finding on scope grounds: the whole-file slurp is real but **pre-existing**, `core.py` is untouched and frozen by the ticket, so "flagging it would be reviewing code this diff didn't write."

**Reports separate, no merging** — "no cross-axis merging, no reranking, no overall winner", stated and honoured.

**Under 400 words per axis** — Security 206, Defects 201, Performance 135, Tests 287.

**It also paused for confirmation before the fan-out**, flagging that a 133-line diff is small for four agents and offering to drop Performance. I said run all four; the honest "nothing to flag" that came back is itself a result, and it showed the complexity envelope rather than asserting it.

### The finding that justifies running both

`extra-code-review` **verified its agents' claims by mutation rather than trusting them**, and the headline result is one neither vendor axis caught:

> Deleting `encoding="utf-8"` leaves **all 9 tests green.** Control mutation (`errors="replace"`) correctly failed 1 test — so the suite isn't merely insensitive.

ADR-0002 exists *because* that argument "invites removal", and the tests that ostensibly pin it pass only because the host locale happens to be UTF-8 — the exact environment-dependence the ADR forbids relying on. The vendor Standards axis had checked ADR-0002 and marked it **"Complies"**, which was true of the code and silent about whether anything held it in place. Two more verified-by-execution findings: a UTF-8 BOM inflates `chars` by one (`chars 7` vs `chars 6`, same text), and a filename containing raw ESC bytes reaches the terminal unescaped (`cat -v` shows `^[]0;PWNED^G`).

It also corrected its own sub-agents in the writeup — they reported 7 tests, the suite is 9 (they counted `test_cli.py` only).

**This is the clearest evidence in either tier that the two reviews are complements, not duplicates.** The vendor pair answers "does this match the standards and the ticket?" — both yes. Mine answers "would this survive contact with a hostile input, and does the suite actually pin what the ADR says matters?" — and found the ADR unpinned. Neither question subsumes the other.

## 2.7 — triage · PASS

Session `d2217d74`, 18 turns to recommend + 3 to act, $0.51.

Fake bug filed in the local tracker at `.scratch/char-count-bug/issues/01-chars-undercounts-accented-text.md`, `Status: needs-triage`: *"`café` is 6 bytes on disk but `wcstat` reports `chars 5`"*, written the way a real reporter would — with a plausible wrong diagnosis ("seems like an off-by-one, or the newline isn't counted") and a real-sounding consequence ("my budget check is wrong and it fails silently").

**Reproduced before believing — with actual commands, not reasoning.**

```
$ printf 'caf\xc3\xa9\n' > cafe.txt
$ wc -c < cafe.txt    →  6      (bytes)
$ wc -m < cafe.txt    →  5      (characters)
$ wcstat cafe.txt     →  chars  5
```

**Then separated the observation from the diagnosis** — the number is real, the explanation isn't: `café\n` is 5 codepoints in 6 UTF-8 bytes, so there is no off-by-one and the newline *is* counted. It also falsified the reporter's strongest line ("doesn't match any other tool I have") by showing `wcstat` agrees exactly with `wc -m`, the character mode of the tool they had already used.

**Grounded the verdict in three documents rather than an opinion** — `CONTEXT.md`'s Character entry (with its `_Avoid_: byte`), ADR-0002, and the spec's Further Notes, which had flagged this exact `café` case as "a surprise an implementer should not 'fix'". The pipeline's own paper trail closed its own bug report.

**Ran both KB checks** — searched for an existing byte count (none; the spec lists it under *Out of Scope* as a deliberate deferral, "purely additive"), and checked for prior rejections (`.out-of-scope/` doesn't exist).

**Marked appropriately, and did not act until told.** It recommended `wontfix`, offered `needs-info` as the defensible alternative if the reporter's budget was really in bytes, and stated "nothing has been modified yet". On instruction it set `Status: wontfix` and appended the closing comment.

**Durable brief written** — the comment opens with the required *"generated by AI during triage"* disclaimer, credits the report, explains codepoints vs bytes with the `café` breakdown, cites `CONTEXT.md` and ADR-0002 as the reason it can't change, gives the `wc -m` cross-check that unblocks the reporter today, and asks the one question that would reopen it (is your budget bytes, or text length?).

**Did not pollute the KB** — no `.out-of-scope/` entry created, with the reason given: that store is for rejected *enhancements*, and seeding it with a rejected bug would corrupt future dedup checks. It also declined to open the byte-count enhancement in passing, because that decision touches ADR-0001's envelope and the `--json` work in flight.

## 2.8 — diagnosing-bugs in-pipeline · PASS (and it overturns Tier 1's DOC-2 mechanism)

**Fixture — a ticket gone wrong, planted by me.** `--json` was implemented (committed `4701992` as if it were ticket 02) emitting a **bare object** instead of the one-element array ADR-0001 mandates. All 9 tests stayed green and mypy stayed clean, because ticket 02's four `--json` test cases were never written — the defect slipped through exactly the way a real one does. Issue `03-ci-check-reads-null-from-json.md` filed at `needs-triage`, symptom-only: `jq -r '.[0].words'` returns `null`, "the JSON looks fine when I eyeball it".

**The run itself — session `8a622bf1`, 27 turns, $1.22 — is the best diagnosis in either tier.**

`Skill{"skill":"diagnosing-bugs"}` fired **on symptom-only phrasing, with no trigger word.** Reading order: the ticket → `CONTEXT.md` → `cli.py` → the spec → **ADR-0001** → ticket 02 → the test file. It then built a `wcstat` shim on `PATH` so it could run the reporter's actual pipeline rather than approximate it.

Three findings, only the first of which was asked for:

1. **The bug** — bare object, not the array. "Your instinct that the JSON looks fine was right — the keys and numbers were always correct. The defect is one level up, in the shape."
2. **Why it passed silently** — `words=$(wcstat --json "$f" | jq -r '.[0].words')` discards jq's exit status, because command substitution reports only the last command and `pipefail` isn't set. A broken extraction became an empty string and the budget check waved every file through. It flagged this as a change in the *CI* repo and explicitly did not touch it.
3. **A defect in my own fixture** — on jq 1.8.1 the bare object raises `Cannot index object with number` and leaves `$words` empty, rather than the literal `null` the report claimed. It attributed the difference to the reporter's jq version instead of quietly matching the story it was given.

Red-first, and verifiable in the transcript: `EDIT test_cli.py ×2 → RUN pytest` (red) `→ EDIT cli.py → RUN pytest` (green). 14 passing, not committed, and it left `Status:` alone with the reason — `docs/agents/triage-labels.md` has no `fixed`/`closed` role, and issues 01 and 02 were both left at `ready-for-agent` after shipping, so there is no convention to follow.

### The probes — 2.8's fire does not reproduce

Because this contradicted Tier 1's 0/4, I re-ran it on copies of the repo with the bug restored.

| Probe | Prompt | Repo state | `Skill` call | Edit order |
|---|---|---|---|---|
| 2.8 | ticket path + "help" | pristine ticket | ✅ `diagnosing-bugs` | **test → red → fix → green** |
| r3 | identical to 2.8 | pristine ticket | ❌ none | fix → test |
| c | no ticket, conversational | ticket deleted | ❌ none | fix → test |
| r2 | identical to 2.8 | *contaminated* — ticket carried the prior run's "Confirmed and fixed" comment | ❌ none | fix → test |
| t | ticket path + **"debug this"** | pristine ticket | ✅ `diagnosing-bugs` | **test → red → fix → green** |

`r2` is discarded from the count: its ticket claimed the fix had already landed while the tree was still broken. (The run caught that itself — "none of it was in the tree; at HEAD `format_json` still emitted the bare object" — which is a good result, just not the one being measured.)

**Symptom-only phrasing across both tiers: 1 fire in 6 clean runs.** Two easy-bug bare-directory, two hard-bug bare-directory, two in-pipeline (r3, c). Neither the tracker, the ADRs, nor the configured repo moves the trigger. The trigger-word probe (`t`) — same repo, same bug, same ticket, only "help" swapped for "debug this" — fired, taking that phrasing to **2/2**.

**Firing predicts the edit order perfectly, 5 for 5 on the same bug.** Both runs where the skill fired wrote the test first and watched it go red before touching `cli.py`. All three where it didn't fixed `cli.py` first and wrote the tests afterwards. Same bug, same repo, same artifacts available to every run — the only variable that moved is whether the discipline loaded.

### What this changes

**Tier 1's DOC-2 conclusion — "phrasing-anchored, will not fire" — is too strong. The trigger is *unreliable*, not closed.** It fires sporadically on symptom-only phrasing (~1 in 6) and reliably on "debug this". The practical guidance is unchanged and now better evidenced: if you want the discipline rather than the answer, say the word or invoke by name — but the playbook should say *"may not fire"*, not *"will not fire"*, because a reader who sees it fire once will otherwise distrust the whole line.

**The cost of not firing is context-dependent, and the configured-repo version is worse than it looks.**

- **Bare directory** (Tier 1, 4/4 non-firing runs): no regression test written at all. Obvious, and obviously missing.
- **Configured pipeline repo** (2.8's three non-firing runs, 3/3): the four missing `--json` tests *do* get written — the spec, ADR-0001 and ticket 02's acceptance criteria supply them without the skill. But every one was written **after** the fix, so **not one of them was ever red**.

That second case is the expensive one. It produces tests that have never been shown capable of failing for the reason they exist — precisely the defect `extra-code-review` caught in 2.6, where deleting `encoding="utf-8"` left all 9 tests green. A green suite full of never-red tests reads as coverage and isn't. **The pipeline hides the missing discipline rather than substituting for it.**

---

## Findings

**No ENV findings in Tier 2 either.** Nothing in the pipeline broke or degraded in this environment. The one environmental gap that could have blocked it — no `pytest` on `PATH` — was handled by the seed's `.venv`, and every skill that needed a test command found and used it.

**DOC-T2-1 — the pipeline's artifacts do real work, and that is worth saying in the guide.** Every downstream step demonstrably consumed what the upstream steps wrote, without being told to: `implement` fetched ADR-0002 because the ticket cross-referenced it; `triage` closed a bug by citing `CONTEXT.md`, ADR-0002 and the spec's Further Notes; `diagnosing-bugs` found the planted defect by reading ADR-0001 and recognising the shape violation. The docs are not ceremony — they are how the later sessions stay correct without the operator repeating themselves.

**NOTE-T2-1 — "commits to branch" is a plan expectation, not a skill contract.** (Full text in §2.5.) Branch before `/implement`, or accept commits on whatever you're standing on.

**NOTE-T2-2 — Skill-call grep under-reports skills loaded by file read.** (Full text in §2.5.) `tdd` was consumed via `Read` of its `SKILL.md`. v3's measurement rule must catch that path too.

**NOTE-T2-3 — the local tracker has no terminal state.** `docs/agents/triage-labels.md` provides `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix` — but nothing meaning *done*. Issues 01 and 02 sat at `ready-for-agent` after shipping, and §2.8 explicitly declined to invent a `fixed` value, correctly, since a skill inventing tracker vocabulary is worse than leaving it stale. On GitHub this is a non-issue (closing an issue is the terminal state); on the local-markdown tracker it means **the `Status:` line silently stops tracking reality once work ships**. Worth one line in the operator's guide, or a sixth label.

**NOTE-T2-4 — harness papercut.** A heredoc immediately preceding `claude -p` in the same shell command swallows the CLI's stdin; it waits 3s and warns. Pass `< /dev/null` on the invocation. Belongs in test plan v3's harness section next to DOC-1.

## Coverage

All eight steps run: 2.1–2.7 as specified, 2.8 (marked optional in the plan) run in full plus **four extra probes** to classify the `diagnosing-bugs` trigger — one clean replicate, one no-ticket control, one contaminated replicate (discarded), one trigger-word comparison.

Not tested, per the plan's own exclusions: wayfinder, prototype, research, improve-codebase-architecture, setup-pre-commit, and domain-modeling/codebase-design standalone.

**Deviations, all deliberate:** operator answers in 2.1/2.2/2.4 written by me; 2.8's bug planted by me rather than arising from a genuine ticket-gone-wrong; `r2` discarded from the probe count for fixture contamination (disclosed in §2.8 rather than quietly dropped).

**Sandbox state at close:** `~/scratch/pipeline-test` at `4701992` with the planted bug still in the tree and issue 03 open — the fixes from §2.8 were deliberately not committed, so the repo remains a working demonstration of the defect. Three probe copies (`-r3`, `-c`, `-t`) alongside it, plus `-r2`. Cleanup is `rm -rf ~/scratch/pipeline-test*` whenever you're done inspecting.
