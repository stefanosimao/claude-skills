# Vendor Layer Test Report — Tier 1

Run: 2026-08-03 · repo `claude-skills` @ `3c65347` (main, clean) · Laptop A (macOS 25.5.0, bash 3.2.57, Claude Code 2.1.220) · plan: `~/Downloads/vendor-test-plan.md`.

Scope: **Tier 1 only** (promoted six, personal scope). Tier 2 not run.

## Method

Each test ran in its own **fresh headless session** (`claude -p`) in a throwaway dir under `~/scratch/tier1/`, not as a subagent of the driving session. This was chosen over the v2 subagent convention for three reasons: `/grill-me`, `/teach` and `/handoff` carry `disable-model-invocation: true`, so they are only reachable by a typed slash command, which a subagent cannot issue; each run gets its own JSONL transcript to grep; and it makes the session-restart tests (1.3, 1.4) real rather than simulated.

Firing was measured by grepping each run's JSONL for `"name":"Skill"` tool calls. Never inferred from prose.

Harness config: `--permission-mode acceptEdits --allowedTools "Bash,Write,Edit,Read,Glob,Grep,Skill,TodoWrite"`. Without this, headless runs auto-deny every prompt and no skill that writes or shells out can be tested at all (see **DOC-1**).

Cost: $7.48 across 13 headless sessions.

| # | Skill | Fired (transcript) | Contract | Verdict |
|---|---|---|---|---|
| 1.1 | grilling | — | — | skipped per plan |
| 1.2 | grill-me | ✅ `Skill(grilling)` | ✅ | **PASS** |
| 1.3 | teach | n/a (slash) | ✅ | **PASS** |
| 1.4 | handoff | n/a (slash) | ✅ | **PASS** |
| 1.5 | resolving-merge-conflicts | ✅ model-invoked | ✅ | **PASS** |
| 1.6 | diagnosing-bugs | ❌ 0/4 symptom-only (2 easy + 2 hard) · ✅ 1/1 on "debug this" | ✅ when fired | **PARTIAL** — see DOC-2, **revised by Tier 2 §2.8** |

---

## 1.2 — grill-me · PASS

Session `812ded71`, dir `~/scratch/tier1/t12`. Prompt: `/grill-me I want to consolidate my two laptops into one`.

**Fired:** transcript shows the wrapper loaded (`<command-name>/grill-me</command-name>` → body "Run a `/grilling` session") followed by an explicit `Skill{"skill":"grilling"}` call. Both layers present, as the plan requires.

**Contract:**
- One question at a time — a single "Question 1 of many", nothing batched.
- Recommended answer attached ("My recommended answer / prior: …" plus a stated prior about the work/personal policy layer).
- Facts looked up, not asked: it ran `df -h` before asking anything and opened with the disk being at 95% (24 GB free of 466), then made that constraint shadow the question.
- **Stateless** — `~/scratch/tier1/t12` was empty before and after. Nothing written anywhere.

**Surprising:** the grilling engine reframed the question one level up unprompted — "consolidation is a *policy* decision wearing a *hardware* costume" — and explicitly told the operator the rest of the tree hangs off that answer. That is the engine working, not drifting.

## 1.3 — teach · PASS

Sessions `686e2d18` (turns 1–2) then `fa7de328` (fresh), dir `~/scratch/tier1/t13`. Topic: bash traps and signals.

**Turn 1 — mission first.** It wrote `RESOURCES.md` only, then refused to build a lesson without the mission: four branches of "traps and signals" named (cleanup / graceful shutdown / error handling / interactive control) and three questions to place the learner. Correct — no lesson written into a vacuum.

**Turn 2 — workspace built.** After the learner answers, it wrote `MISSION.md`, `NOTES.md`, `learning-records/0001-prior-knowledge-and-starting-point.md`, `lessons/0001-cleanup-that-always-runs.html`, `reference/trap-cheatsheet.html`, and `assets/{lesson.css,quiz.css,quiz.js}`.

**ZPD scoping — the strongest result in this test.** `MISSION.md` records "Already fluent with `set -euo pipefail`; has never written a `trap`. **Start at trap zero, not bash zero.**" The learning record turns that into teaching decisions: skip "what is an exit status" entirely, and teach the `tmpdir=''` pre-declaration *as a consequence of `set -u`*, which the learner already runs, "rather than as arbitrary ceremony". Lesson 1 is ~1,270 words on exactly one thing (EXIT-trap cleanup). `MISSION.md` also pinned the local bash as 3.2.57 vs 5.x in CI/container — an environment lookup, not a question.

**State survives session restart — verified.** A fresh session (no `--resume`) in the same dir, given only "let's continue", read `MISSION.md` → `NOTES.md` → `RESOURCES.md` → the learning record → lesson 1 → the cheat sheet, then opened with: *"Picking up where session 1 left off: lesson 1 (EXIT cleanup) and the cheat sheet are done; lesson 2 is queued as 'killing the background jobs your script leaves behind'. Per your notes, I verify behaviour on your actual bash 3.2.57 before writing anything."* It then ran ~15 empirical bash experiments on the local shell before writing `lessons/0002-children-that-outlive-you.html` — including finding that `wait` inside a trap swallows the rest of cleanup and rewrites the exit status to 143, and stopping to pin that down before teaching it.

**The continuation also revised prior state rather than only appending to it.** `NOTES.md` grew from 2.4 KB to 6.2 KB, and the run's own summary flags *"Fact 4 in your notes needed refining"* — an earlier claim about signal deferral, corrected against measured behaviour (a trapped `TERM` handler ran 7s late and the script then exited 0; with only an `EXIT` trap the shell died at 143). It also found `set -e` live inside the handler, so a `kill` against an already-dead PID aborts cleanup mid-way and reinstates exactly the leak lesson 1 fixes. Both findings changed what lesson 2 says and reset lesson 3's opening.

**Caveat on this test:** the learner's answers were written by me, not by Stefano — the mission is plausible but fictional.

## 1.4 — handoff · PASS

Run on the 1.5 merge session (`be203db3`) rather than the teach session, because redaction cannot be measured on a conversation with nothing to redact. Deviation from the plan, deliberate: I first seeded one turn with a fake GitHub PAT, an internal dashboard URL, a dashboard login, and an on-call engineer's name and mobile number, then ran `/handoff a fresh session that will split TIMEOUT into separate health-check and upload constants`.

**Contract:**
- **Temp dir** — written to `$TMPDIR/handoff-t15-timeout-split.md` (`/var/folders/hl/…/T/`), not the workspace. ✅
- **Secrets redacted** — grep for the token, the password, the dashboard host, the on-call name and the phone number over the finished doc: **0 matches**. What survives is the structural fact ("a deploy script outside this repo reads this config and authenticates using a `DEPLOY_TOKEN` environment variable"), plus a note that rotation was advised and follow-through is unknown, so the next session does not assume the credentials are dead. ✅
- **Artifacts referenced, not duplicated** — the three commits are cited by hash (`dfa810b`, `3052635`, `5e08311`) with "they contain the full reasoning and are not reproduced here". On the source file: "Read the file; it's shorter than any summary of it." ✅
- **Suggested skills** section present, and it names a skill *not* to use ("Not `resolving-merge-conflicts` — the merge is finished and committed"). ✅

**Fresh session pickup — coherent.** Session `adf07a4b` in an unrelated empty dir, given only the doc path, located the real repo, read all three commit messages, confirmed the handoff's account, and came back with a three-option API design table plus a recommendation. It also **caught an error in the handoff**: the doc says `config.py` is "ten lines"; it is six. Verified rather than trusted — the right behaviour, but the inaccuracy is real (**NOTE-2**).

## 1.5 — resolving-merge-conflicts · PASS

Session `be203db3`, dir `~/scratch/tier1/t15`. Fixture: `TIMEOUT` moved off base 30 in both directions — `main` → 5s (LB marks a node unhealthy after 10s), `feature/slow-network` → 120s (3G upload p99) — each with the reasoning in its commit message. Merge started and left conflicted; prompt was "I started a merge in this repo and it blew up. Can you finish it?"

**Fired:** `Skill{"skill":"resolving-merge-conflicts"}`, model-invoked, immediately after the first `git status`. No slash command, no nudge.

**Contract:**
- **Both intents understood from the commits** — it ran `git log --format='%H%n%an %ad%n%s%n%b%n---' --all` and `git show <base>:config.py`, and its summary reproduces both production arguments accurately.
- **Never `--abort`** — the only three occurrences of `--abort` in the transcript are git's own status hint (×2) and the skill text itself. The assistant never proposed it.
- **Completed the merge** — `5e08311`, tree clean, `__pycache__` cleaned up after the verification run.
- **Trade-off named rather than invented** — it took 120 ("the merge's purpose is to land `feature/slow-network`"), explicitly refused to average the two values ("inventing a value neither commit argued for"), and wrote the regression into the commit message: an unhealthy node now hangs ~12× past the LB's 10s probe.
- **Checks discovered and run** — found no test suite/CI/manifest, so `py_compile` + import, and said plainly that "a green check means very little" here.

**Surprising (good):** it volunteered the durable fix (two constants), said why it did *not* do it — no call sites in the repo to route, so it would mean designing an API the merge didn't ask for — and offered to amend to 5 since nothing is pushed.

## 1.6 — diagnosing-bugs · PARTIAL

Fixture: `inventory.py` with a mutable-default-arg bug (`pack_order(items, box=[])` accumulating across calls, so `summarise` returns the same list three times), plus two lookalikes that are *not* live bugs (`order_total`'s read-only `discounts={}`).

Three runs, same fixture, only the prompt wording varying:

| Run | Prompt | `Skill` call | Discipline |
|---|---|---|---|
| 1.6 (`f786869a`) | plan's wording: "…this sometimes returns wrong results, help." | **none** | read → run → edit → verify |
| 1.6-r2 (`93e6f270`) | identical repeat | **none** | read → run → edit → verify |
| 1.6-b (`6094ad8c`) | "…sometimes returns wrong results, **debug this**." | ✅ `diagnosing-bugs` | full loop |

**When it fires, the contract holds completely.** Run 1.6-b: announced "feedback loop first, before theorizing"; wrote `test_inventory.py` with four assertions red on the exact symptom; when `pytest` was missing, **built a venv and installed it rather than settling for a weaker signal** — arriving at "`.venv/bin/python -m pytest test_inventory.py -q` — 0.06s, deterministic, 4 red on the exact symptom"; then minimised to a two-call repro and proved the cause directly (`pack_order.__defaults__[0] is <returned box>` → True) rather than ranking hypotheses; fixed; re-verified 7 green. Regression test existed **before** the fix. That is the skill working exactly as written.

**When it does not fire, the outcome is right and the discipline is absent.** Runs 1.6 and 1.6-r2 both diagnosed correctly and fixed correctly — but jumped from one `python3 inventory.py` straight to `Edit`, with no failing test, no minimisation, and no regression test on disk. The fix is verified only by an ad-hoc one-liner. Both runs also (correctly) noted that `order_total`'s mutable default is not currently a bug, so the lookalikes did not fool them.

### 1.6-hard — the altitude probe

Run to settle the classification: is the trigger *correctly calibrated to altitude* (easy bugs don't deserve the ceremony, per the skill's own "hard bugs" framing), or is it anchored on phrasing? A hard bug under symptom-only phrasing separates the two.

**Fixture** (`sales/`, three modules + CSV): `aggregate.py` dedupes order lines through `for key in set(lines)`. Python randomizes string hashing per process, so the set iterates differently every run, which changes the insertion order of `totals`; `report.py` then picks the winner with `max()`, which returns the *first* key holding the max value. Two products tie at exactly 1200.00 after dedup. Net effect: same input file, different headline product on roughly 1 run in 4, with the cause split across three modules and invisible in any single one. Verified before the probe: 6 baseline runs gave 5× "Borealis Mug", 1× "Aurora Lamp".

**Prompt** (same symptom-only register as 1.6, no trigger word): *"Our daily sales report names a different top product on different runs even though orders.csv hasn't changed — this sometimes returns wrong results, help."*

**Result — `Skill` call in neither run.** 0/2.

| Run | `Skill` call | What it did instead |
|---|---|---|
| hard1 (`35701ce7`) | **none** | read 3 modules → swept `PYTHONHASHSEED=0..7` → fixed → re-swept 10 seeds |
| hard2 (`72f8c4b7`) | **none** | read 3 modules → 8 plain runs → isolated `revenue_by_product` → fixed → re-verified across forced seeds |

**Both solved it correctly and neither left a test behind.** The diagnoses are genuinely good — hard2's writeup nails the full mechanism ("the report body silently reordered on *every* run, but the headline only changed when the shuffle happened to put Borealis Mug first") and both surfaced the judgement call the fix conceals: the tie is real data, so an alphabetical tie-break is "a coin flip dressed up as an answer". Both independently reached for a seed sweep as their signal, which is the right instinct. But it is an ad-hoc shell loop, not a durable one: `find` over both dirs afterwards shows **no test file of any kind**. Compare 1.6-b, where the skill fired and `test_inventory.py` was red before a line was edited.

**Classification (as of Tier 1 — see the correction below): the trigger looked phrasing-anchored, not altitude-calibrated.** Symptom-only phrasing is now 0/4 across both difficulty levels (2 easy, 2 hard); "debug this" is 1/1. Difficulty made no difference — the hard bug is exactly the case the skill was written for, and it still did not fire. So the charitable reading offered above ("easy bugs don't deserve the ceremony") does not survive the probe, and **DOC-2 is load-bearing rather than a nicety**: without a trigger word, the pipeline gets correct answers with no regression test and no red-first loop. This remains a documentation fix, not a skill edit — vendor stays verbatim.

> **Correction, added after Tier 2 §2.8 (same day).** The "will not fire" reading above does not survive more data. In the pipeline sandbox, `diagnosing-bugs` **did** fire on symptom-only phrasing once, then failed to fire on two clean replicates of the identical prompt. Pooled across both tiers, symptom-only phrasing is **1 fire in 6 clean runs**, not 0 in 4 — the trigger is *unreliable*, not closed. The operational advice is unchanged and better evidenced; the mechanism claim is not. See Tier 2 §2.8 for the probe table and for what the miss actually costs in a configured repo.

---

## Findings

**DOC-1 — headless/CI runs need explicit tool grants.** Any test or automation that drives these skills through `claude -p` must pass `--permission-mode acceptEdits` and an `--allowedTools` list. In the default mode every permission prompt is auto-denied non-interactively, so `teach` writes nothing, `resolving-merge-conflicts` cannot run git, and `diagnosing-bugs` cannot build a feedback loop — all of which look like skill failures and are not. Worth a line in the operator's guide and in test plan v3.

**DOC-2 — say "debug this" or invoke `diagnosing-bugs` by name. Load-bearing.** _(Counts below revised after Tier 2 §2.8 — this is the final version.)_ Symptom-only phrasing ("this sometimes returns wrong results, help") fired it in **1 of 6 clean runs**: 0/2 easy-bug bare directory, 0/2 hard-bug bare directory (non-deterministic, three modules), 1/2 in a fully configured pipeline repo — where the one fire did **not** reproduce on a clean replicate of the identical prompt. "Debug this" fired it **2/2**, both times with the full loop. The altitude probe rules out "the trigger is calibrated to difficulty": the hard bug is precisely this skill's stated territory and still did not reach it. Neither does a tracker, a spec, or an ADR sitting in front of it.

The cost of the miss depends on where you are, and the better-looking case is the worse one:

- **Bare directory** (4/4 non-firing runs here): the bug is diagnosed and fixed correctly, but **no regression test is written at all** and there is no red-first loop. Obvious, and obviously missing.
- **Configured pipeline repo** (Tier 2, 3/3 non-firing runs): the missing tests *do* get written — the spec, the ADR and the ticket's acceptance criteria supply them without the skill — but every one is written **after** the fix, so **not one was ever red**. That yields tests which have never been shown capable of failing for the reason they exist, which is precisely the defect `extra-code-review` caught in Tier 2 §2.6. A green suite of never-red tests reads as coverage and isn't.

Playbook line becomes: *Hard bug → diagnosing-bugs — say "debug this" or invoke by name; symptom-only phrasing **may not** fire it (1 in 6 here).* Note the "may": it does fire occasionally, and a reader who sees that once will distrust a line that says "will not". Applies with force at pipeline step 2.8. No skill edit implied.

**DOC-3 — `/grill-me`, `/teach`, `/handoff` will never appear in the model's skill list.** All three carry `disable-model-invocation: true`, so a session asked "which skills do you have?" reports only `grilling`. Confirmed directly: a headless probe listing grill/teach/handoff skills returned `grilling` alone. Test plan v2 §0 ("confirm all skills appear in your available skills… missing skills = BLOCKER") would produce a false blocker on the vendor layer. v3 should check these three by invoking them, not by listing.

**NOTE-1 — `teach` builds its lab outside the workspace, and tears it down.** The continuation session ran its 14 bash experiments in `/tmp/trapslab` rather than polluting the teaching workspace, then removed the directory before finishing (`/tmp/trapslab` confirmed absent afterwards). No finding; recorded because "where does an empirical lesson do its work" is a fair question to have about this skill, and the answer is clean.

**NOTE-2 — one factual slip in the handoff doc.** It described `config.py` as "ten lines"; it is six. The receiving session caught it by reading the file first. The contract ("reference, don't duplicate") is what made this cheap — the doc pointed at the file instead of restating it.

**NOTE-3 — no ENV findings.** Nothing in the promoted six broke or degraded in this environment. Everything that differed from Matt's setup (bash 3.2.57 vs 5.x, no pytest on PATH) was detected and handled by the skills themselves rather than tripping them.

## Coverage

Tested: 1.2, 1.3, 1.4, 1.5, 1.6 (+4 extra probes on 1.6: one trigger-word variant, one repeat, two hard-bug). Skipped per plan: 1.1.

Deviations from the plan, all deliberate and disclosed above: fresh headless sessions instead of subagents (slash commands are unreachable from a subagent); `/handoff` run on the 1.5 merge session with seeded fake secrets instead of "any of the above sessions" (redaction is unmeasurable otherwise); 1.3's learner answers written by me.

Cleanup: `rm -rf ~/scratch/tier1 "$TMPDIR"/handoff-t15-timeout-split.md` — not yet run, artifacts left in place for inspection. (`/tmp/trapslab` needs no cleanup; `teach` removed it itself.)
