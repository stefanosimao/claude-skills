# Skill Test Report — v1

Run: 2026-07-28 · repo `claude-skills` @ `76c146e` (main, clean) · 13 skills under test · vendor layer out of scope.

Method: one fresh `general-purpose` subagent per prompt, given the prompt **verbatim and nothing else**. Skill invocation was measured by grepping each subagent's JSONL transcript for `Skill` tool calls, not inferred from prose. 24 subagents total.

## 0. Setup check — PASS

- All 13 skills present in `skills/` and loaded in the session skill list.
- `anagram.py "attore" --check "teatro"` → `bank: aeortt (6 letters)` / `YES — 'teatro' is an exact anagram`.

## 1. Routing matrix — 13/13, PASS

| # | Prompt | Expected | Observed (Skill tool call) | Verdict |
|---|---|---|---|---|
| 1 | two job offers, safe vs. risky startup | reasoning-toolkit | `reasoning-toolkit` | ✅ |
| 2 | pre-mortem on self-hosting email | reasoning-toolkit | `reasoning-toolkit` | ✅ |
| 3 | stuck organizing research notes | reasoning-toolkit | `reasoning-toolkit` | ✅ |
| 4 | analyze the remote-work/RTO argument | argument-analysis | `argument-analysis` | ✅ |
| 5 | prep me to debate school uniforms | argument-analysis | `argument-analysis` | ✅ |
| 6 | landlord wants +12% rent | negotiation-persuasion | `negotiation-persuasion` | ✅ |
| 7 | reply to angry client, relationship matters | negotiation-persuasion | `negotiation-persuasion` | ✅ |
| 8 | service layer returning DB entities | software-engineering | `software-engineering` | ✅ |
| 9 | Claude project for quantum computing | project-setup | `project-setup` | ✅ |
| C1 | Python CSV sum function | **none** | none (1 tool use, no Skill) | ✅ |
| C2 | capital of Australia | **none** | none (0 tool uses) | ✅ |
| C3 | colleague wrong about Kubernetes | **none** | none | ✅ |
| C4 | birthday message for my mother | **none** | none | ✅ |

**Score: 9/9 should-fire, 0/4 false positives.** Every auto skill clears the ≥2/3 bar at 3/3 or 2/2.

The two control prompts designed as near-misses behaved exactly as intended, which is the strongest single result in this run:

- **C3 (Kubernetes)** — argument-analysis did *not* fire. The agent instead *named* argument-analysis, negotiation-persuasion and software-engineering as things it could run and asked which the user actually wanted. That is the desired behaviour: offer, don't hijack.
- **C4 (birthday message)** — negotiation-persuasion did not fire on a message-drafting request with no stakes, and the reply was a plain warm draft. The "don't hijack routine message drafting" guard in the description is holding.

## 2. Manual skills — invocation and contract

| Skill | Invoked | Contract | Notes |
|---|---|---|---|
| ask-tete (a) foggy greenfield | ✅ | ✅ | Recommended `/wayfinder`, gave `/grill-me` as the tiebreaker alternative, **handed over the command for a fresh session and explicitly refused to start it** ("orchestrators deserve clean context"). Also surfaced the `/setup-matt-pocock-skills` precondition and the `/to-spec → /to-tickets → /implement` merge point. |
| ask-tete (b) diff security | ✅ | ✅ | Routed to `extra-code-review`, correctly framed as **alongside** `/code-review` and contrasted against built-in `/security-review`. Noticed the repo is clean on main and said so. Did not start it. |
| ask-tete (c) track calories | ✅ | ⚠️ pass w/ note | Flagged the catalog gap correctly and refused to improvise. Routed **primarily to `project-setup`**, with `/skill-forge` as the conditional handover if the user wants method rather than log. The plan expected skill-forge first; the reasoning given (data accumulates daily → project, not skill) is sound and is the framework working as designed. Recording as a plan-expectation mismatch, not a defect. |
| skill-forge | ✅ | ⚠️ partial | See **FIX-1**. |
| study | ✅ | ✅ | Consulted Drive `negotiation-persuasion/`, built a 5-phase path **sequenced by chapter, deliberately out of book order** (Voss 2→3→5→4→7, with the reason stated), forked phase 3 by mission, attached named retention methods with Dunlosky's ranking, listed failable checkpoints, and named what it deliberately excluded. **No fabrication** — every title matches the owned folder, and the gap list (Getting to Yes, Negotiation Genius, Difficult Conversations, Influence 2021 ed.) is flagged as *not owned* rather than cited. Did not write to `_sources.md` unasked. |
| society-lenses | ✅ | ✅ | Web-searched the 23 July 2026 ECB hold first and separated "factual layer" from "analytical layer" explicitly. Applied **5 named lenses** (Marshall, Sowell, game theory, Dalio, Durant), each with a "what it conveniently ignores" section. Staged Sowell vs. Chang vs. Sandel as live disagreement rather than averaging them. **No personal verdict**; closed with an arbitration watchlist. |
| extra-code-review | ✅ | ✅ | Named all **4 axes** with their canon; **pinned the fixed point** (`git merge-base HEAD~1 HEAD` → `3d96026`) and paused for confirmation before spawning; specified **one parallel sub-agent per axis**, reports kept separate, **<400 words each**; recited the **overlap guards** (no Fowler smells, no spec conformance, no architecture verdicts, no bug diagnosis). Bonus: noticed `HEAD~1...HEAD` is a one-line doc change and recommended widening the fixed point rather than burning four agents on it. |
| settimana-enigmistica | ✅ | ✅ | Ran the script (`aeortt` bank), answered **TEATRO**, noted the semantic pairing attore↔teatro as the signature of the intended solution, and disclosed `ROTATE` as letter-valid but semantically unlinked. Answered in Italian. |
| swiss-voting | ✅ | ✅ | Hit admin.ch and cantonal sources live; found 27 Sept 2026 (Neutralitätsinitiative, Ernährungsinitiative) plus the Aarau/Unterentfelden fusion. Reported the Bundesrat/Parliament recommendations **as fact, not endorsement**. On the pushed follow-up *"just tell me what to put on the ballot"* it **refused cleanly**, explained why (values disagreement, no neutral vantage point), and offered to map both committees' arguments onto the user's stated priorities instead. |
| bonsai-care | ✅ | ✅ | Opened with **dormancy-vs-death** ("ficus has no true dormancy, so leaf drop is always a response"), **mechanism first** (leaf light-budget economics, abscission funded from trunk/root starch), then put the **scratch test as step 1 before any advice**. Correctly identified the real killer as over-watering a leafless tree, gave a 3–8 week timeline and good/bad watch-fors. Cited sources. |

Symmetry note on swiss-voting: the initial answer gave a neutral overview and *offered* the both-committees breakdown rather than delivering it unprompted. Appropriate for "what are we voting on next?", but the full symmetric-arguments contract was exercised only by offer, not by delivery.

## 3. Fetch cascade — PASS

Prompt: *"what does Thinking in Bets actually say about resulting — chapter please"*

Transcript-verified tool sequence: 2 × `Drive search_files` → **1 × `read_file_content`, fileId `1zDsSB…`, `mimeType: text/markdown`, 33 KB** — the summary. **The PDF was never fetched.**

Answer cited **ch. 1 "Life Is Poker, Not Chess"**, section *"The hazards of resulting"*, and correctly routed the constructive material to ch. 3 (luck/skill fielding) and ch. 6 (memorialised decision trees). All chapter numbers trace to the summary's chapter map. **No fabrication.** It also relayed the summary's own verdict that ch. 1 is the book's lowest-yield chapter — the "honest librarian" behaviour working.

One deviation from the plan's prediction: this prompt fired **`study`, not `reasoning-toolkit`**. See **NOTE-1**.

## Findings

### FIX-1 — skill-forge asserts invocation mode instead of asking · FIX (body)
The contract requires intent capture and the Skill-vs-Project check *before* drafting, and requires **asking** about invocation mode. Observed: classification ran first and correctly (hybrid, skill-first, with the project deferred until non-log notes accumulate), and budget + collision checks ran. But invocation mode was **decided and announced** — "auto(narrow), claude.ai-enabled, a departure from bonsai-care's manual pattern, deliberately" — with justification, not offered as a question. It also produced `SKILL.md` + 3 reference files while six intake questions were still open and self-described as "blocking a build".

Mitigating: the prompt said *"sketch"*, which invites a draft; output went to scratchpad, not the repo; catalog.md was untouched; open questions were listed explicitly. So the drafting-ahead is defensible, the un-asked invocation decision is not.
**Suggested body change:** in the intake step, make invocation mode a mandatory question with a recommendation attached, rather than a derived decision — e.g. "I'd propose auto(narrow) because X; confirm or override before I draft."

### FIX-2 — three skills ship an empty `references/` directory · FIX (housekeeping)
`negotiation-persuasion`, `society-lenses`, and `software-engineering` each contain `references/` with zero files (confirmed in both `skills/` and the synced `~/.claude/skills/`). The software-engineering subagent independently noticed this and flagged that all grounding therefore came from Drive with **no local fallback if Drive is unavailable**.

All three scored full marks in testing, so nothing is functionally broken — these are pure Drive-cascade skills. But an empty committed directory is ambiguous: either delete it, or add a stub explaining that grounding is Drive-only by design.
**Reference-file counts for contrast:** settimana-enigmistica 4, bonsai-care 2, reasoning-toolkit 2, skill-forge 2, argument-analysis 1, extra-code-review 1, project-setup 1.

### NOTE-1 — depth question routes to `study`, not `reasoning-toolkit` · COSMETIC
Section 3 predicted reasoning-toolkit would fire on *"what does Thinking in Bets say about resulting"*. `study` fired instead. The cascade behaviour under test — Drive summary, chapter-accurate, no full-book fetch, no fabrication — was **fully correct**, so the test's actual object passed. The routing is arguably better than predicted: "what does book X say" is librarian work. No change recommended to either skill; **update the test plan's expectation** in v2.

### NOTE-2 — ask-tete (c) routes to project-setup before skill-forge · COSMETIC
Covered in the table above. Behaviour is correct per the Skill-vs-Project-vs-Hybrid framework. **Update the test plan's expectation** rather than the skill.

## Verdicts

| Skill | Verdict |
|---|---|
| reasoning-toolkit | **PASS** |
| argument-analysis | **PASS** |
| negotiation-persuasion | **PASS** (see FIX-2, housekeeping only) |
| software-engineering | **PASS** (see FIX-2, housekeeping only) |
| project-setup | **PASS** |
| ask-tete | **PASS** |
| study | **PASS** |
| society-lenses | **PASS** (see FIX-2, housekeeping only) |
| extra-code-review | **PASS** |
| settimana-enigmistica | **PASS** |
| swiss-voting | **PASS** |
| bonsai-care | **PASS** |
| skill-forge | **FIX BODY** (FIX-1) |

## Proposed description rewrites

**None.** Workflow A step 5 is not needed for this run. Zero trigger failures and zero false positives means no description is either too pushy or too narrow, and the two near-miss controls (C3, C4) confirm the negative guards in `argument-analysis` and `negotiation-persuasion` are doing real work. Changing any description now would be changing something that is measurably correct.

## Test-plan maintenance for v2

1. Section 3: expect `study`, not `reasoning-toolkit` (NOTE-1).
2. Section 2 ask-tete (c): expect `project-setup` primary with `skill-forge` as the conditional handover (NOTE-2).
3. Add a swiss-voting sub-case that *demands* the symmetric both-committees breakdown, so that contract is exercised by delivery rather than by offer.
4. Record the transcript-grep method (`grep '"name":"Skill"'` over the subagent JSONL) in the plan — it makes "did it fire?" an observation rather than an inference.

*(All four folded into `skill-test-plan-v2.md`, alongside this file in `tests/`.)*

---

# Addendum — v1.1 re-test

Run: 2026-07-28, after commit `777e418` + `./scripts/sync.sh`. Two fresh subagents, prompt verbatim, same transcript-grep method. **Both PASS.**

Sync verified before testing: the fixed strings are present in `~/.claude/skills/` (`Propose invocation, then WAIT`, `Vendor commands are repo-scoped`), and both strings appear in the subagents' own transcripts — so each agent loaded the **post-fix** skill body, not a stale session copy. No session restart was needed.

## Re-test 1 — skill-forge (FIX-1) · PASS

Prompt: *"use skill-forge to sketch a skill for tracking my espresso recipes"*

| Criterion | Result |
|---|---|
| Runs classification first | ✅ Hybrid, with the method/data split tabulated and the two deciding framework signals named (content is my data · grows continuously) |
| **Asks** the invocation question, recommendation attached | ✅ "**Recommendation: auto(narrow)**" with reasoning, "**Alternative: manual**" with the bonsai-care precedent, closing on "**Confirm or override before I draft anything.**" |
| No SKILL.md / reference files while blocking questions open | ✅ **Zero `Write`/`Edit` tool calls in the entire transcript.** Opened with "I ran skill-forge in CREATE mode and stopped at the drafting gate — a 'sketch' earns the outline plus the open questions, not the files. No SKILL.md was written." |
| Outline-only acceptable | ✅ Structure given as an outline (name, SKILL.md sections, `references/` files, deliberate exclusions), then 5 blocking questions each with a recommended answer |

Contrast with v1, where the same prompt produced `SKILL.md` + 3 reference files in scratchpad and *announced* "auto(narrow), deliberately" without asking. **The fix holds.**

Two unprompted improvements worth noting, neither required by the fix:
- It surfaced a real platform constraint — **on claude.ai a skill cannot write persistent files**, so a claude.ai-only espresso skill can advise but not track. That reframes question 1 (where the log lives) from preference to constraint.
- It cited the calorie-tracking routing precedent from `catalog.md` as prior art for the same classification call, i.e. the catalog is being used as a decision record rather than re-litigated.

## Re-test 2 — ask-tete (FIX-3) · PASS

Prompt: *"ask tete: I have a huge foggy greenfield project idea"*

| Criterion | Result |
|---|---|
| Recommends wayfinder, with tiebreaker | ✅ `/wayfinder` primary, `/grill-me` as the alternative, tiebreaker question stated |
| **Vendor-availability precondition** | ✅ "These are Matt-layer commands and they're **repo-scoped, not account-wide. A brand-new repo has neither, so the command dies on arrival without this**" — followed by 3 numbered install steps: `git init` → copy the vendor set **whole** (`vendor/mattpocock/*` → `.claude/skills/`) → `/setup-matt-pocock-skills` once |
| Precondition comes BEFORE the command | ✅ Install block precedes the `/wayfinder` handover |
| Still hands over rather than starting | ✅ "I'm not starting it from here on purpose — orchestrators never get launched from inside another skill" |

Contrast with v1, where the precondition appeared as a *sequencing* note ("run setup once first") without the availability consequence, and only because the agent was being diligent. It is now stated as a hard precondition with concrete commands — including the greenfield-specific `git init` step the rule doesn't mention, correctly inferred from "greenfield".

## Verdicts after fixes

| Skill | v1 | v1.1 |
|---|---|---|
| skill-forge | FIX BODY | **PASS** (1.1) |
| ask-tete | PASS (partial on FIX-3) | **PASS** (1.0.1) |
| negotiation-persuasion · society-lenses · software-engineering | PASS + housekeeping | **PASS** (1.0.1) — stubs added, Drive-unreachable caveat added; not re-tested, the change is documentation plus one degradation rule with no trigger surface |

**All 13 skills now PASS with no open findings.** Status stays 🧪 draft-built until deployment (claude.ai upload + Laptop B sync); ✅ installed is a claim about the enabled-where column, not about testing.

> **Amendment 2026-08-04** (appended, not rewritten — the line above records what was true when the report ran). The "Laptop B sync" half of that gate is **withdrawn**: it tracked a machine's state rather than a property of these skills, and it blocked the 🧪→✅ sweep on a machine that may never be opened. Machine currency is now a procedure, [`docs/new-machine-setup.md`](../docs/new-machine-setup.md), and ✅ is defined per-machine (see the catalog legend). The **claude.ai upload half stands** and is still outstanding. The sweep ran on 2026-08-04 against Claude Code evidence only; the sentence's closing clause — that ✅ is a claim about enabled-where and not about testing — is unchanged and is exactly why the claude.ai half still gates.

---

# Addendum — v1.0.2 re-test (ask-tete bare invocation)

Run: 2026-07-28, after commit `8419bed` + `./scripts/sync.sh`. Two fresh subagents. **Both PASS**, with one caveat on test 2's strength (below) and one real finding surfaced.

## Re-test 1 — bare `/ask-tete` inside the repo · PASS

Prompt: *"ask tete"*

| Criterion | Result |
|---|---|
| Lists rather than routes | ✅ Full catalog listing; no attempt to guess a situation |
| Catalog's own groups | ✅ Meta · Thinking & learning · Programming Layer 2 · Personal, then the Matt layer by phase |
| Invocation mode + one-line purpose per skill | ✅ Every row |
| **Live read of catalog.md** | ✅ Transcript shows `Bash` probe of the clone root → `Read /Users/stefanosimao/claude-skills/catalog.md`. Opened with "Listing live from … (current, not snapshot)" |
| Availability marked in current context | ✅ All 13 personal skills "synced and available here"; **vendor layer correctly reported NOT active** — it checked and found `claude-skills/.claude/skills/` empty, so "none of these commands resolve here yet", with the install steps |
| No Anthropic built-ins listed | ✅ Zero |
| Closes with the question | ✅ "So — what are you actually trying to do right now? I'll route it." |

## Re-test 2 — bare `/ask-tete` from a directory outside the clone · PASS (weak, by design)

Prompt ran `cd` to the scratchpad first, then *"ask tete"*.

Result: identical grouped listing, all criteria above met, closing question present — but the transcript shows it **still read `catalog.md` live**, exactly as predicted. The skill's fallback chain checks `~/claude-skills/`, and the clone *is* `/Users/stefanosimao/claude-skills`, so the repo is never unreachable from this machine regardless of cwd. Working-tree renames were ruled out as a test method.

**So the snapshot path was not exercised end-to-end.** What was verified instead, statically:

- `~/.claude/skills/ask-tete/references/catalog-snapshot.md` exists and is reachable from the synced skill (4,375 bytes), header `Snapshot of catalog.md @ 65b9379`.
- The caveat wording is present in the synced `SKILL.md:56` — fall back to the snapshot "and say so — *listing from snapshot @ `<commit>` — may be stale*".
- The stamp resolves: `git cat-file -t 65b9379` → `commit`.

**Not to be mistaken for untested:** the fallback gets a genuine production test for free at deployment. Every bare `/ask-tete` on claude.ai runs the snapshot path, because no repo exists there at all. First claude.ai invocation after upload is the real test — check that it names the snapshot and states staleness rather than silently listing.

### Snapshot stamping — resolved during this run

The first attempt stamped HEAD, then chased the correct value via `git commit --amend`, which rewrote the hash and left the stamp pointing at a commit that no longer existed. A file cannot hold the hash of the commit that contains it, so the chase regresses forever. Settled convention, now written into skill-forge step 6: stamp **catalog.md's last-touching commit at generation time** (`git log -1 --format=%h -- catalog.md`, run *before* committing), never HEAD, and never amend to close the one-commit gap — that gap is inherent, not drift.

## Finding — catalog `Enabled` column is behind reality · FIX (bookkeeping)

Test 2 surfaced it unprompted: the catalog marks `bonsai-care`, `settimana-enigmistica` and `swiss-voting` as **claude.ai-only**, but `scripts/sync.sh` copies all 13 skills to `~/.claude/skills/`, so all three are live in Claude Code too. Test 1 hit the same fact and phrased it as "claude.ai-primary, but present on this machine."

The listing is doing exactly the job it was added for — making enabled-where discipline visible — and it immediately caught the column lying. Two ways to reconcile, needs a ruling:

1. **Correct the catalog** — mark the three as CC + ai, since that is what sync.sh actually does.
2. **Correct the sync** — if those three are deliberately claude.ai-only, `sync.sh` should skip them rather than the catalog being wrong.

Not changed; the answer depends on intent, not on the code.

---

# Addendum — Decision 30: promoted vendor skills (2026-07-28)

**Verdict: PASS.** First test of a vendor skill running outside a repo that has the vendor set installed.

## What changed

Vendor scope became a per-skill decision (catalog Decision 30). Six skills — `teach`, `handoff`, `grilling`, `grill-me`, `resolving-merge-conflicts`, `diagnosing-bugs` — are now synced to personal Claude Code scope by `scripts/sync.sh`'s `PROMOTED_VENDOR` list. The other 16 remain repo-scoped. Verbatim and pin rules untouched; only scope moved.

Standalone-ness was re-verified before promoting rather than taken from the audits on trust: grep across all six for `docs/agents`, `tracker`, and `setup-matt-pocock` returned zero hits. The user/model invocation split in the catalog was likewise read off each skill's frontmatter (`disable-model-invocation: true` on teach / handoff / grill-me) rather than assumed.

## Sync verification

`./scripts/sync.sh` → `Synced 13 skill(s) + 6 promoted vendor skill(s)`. `ls ~/.claude/skills/` = **19**, all six promoted folders carrying a `SKILL.md`.

## Test — grilling fires outside a vendor-installed repo

Prompt, given verbatim and alone to a fresh subagent: *"I'm planning a 3-week sabbatical and want my plan stress-tested — grill me."*

**Firing measured by transcript grep**, per the standing method:

```
$ grep -o '"name":"Skill","input":{"skill":"[^"]*"' agent-adbf067b26044cd7c.jsonl
   1 "name":"Skill","input":{"skill":"grilling"
```

Before the promotion this could only have fired inside a repo with `vendor/mattpocock/` copied into `.claude/skills/`. It fired from personal scope, install-free — which is the whole point of Decision 30.

**Interview discipline held.** One question asked, not a battery. A recommended answer supplied with it ("pick exactly one primary purpose and demote the others"), plus a tiebreaker question for the case where the user can't choose. It acted on nothing and asked before proceeding. Signature phrases from the skill body appear in the transcript: `recommended answer` ×4, `decision tree` ×3, `shared understanding` ×6 — the vendored body loaded, not a general-knowledge imitation of an interview.

**Unprompted bonus, worth recording:** it checked the calendar before asking anything and opened with the strongest possible grilling move — *"No sabbatical exists on your calendar… whatever the plan is, it currently lives only in your head."* Looking up facts itself and reserving questions for genuine *decisions* is exactly the contract the skill states.

## install-vendor.sh — smoke test, 7/7

| Case | Result |
|---|---|
| shared install into a throwaway repo | 22/22 skills, exit 0 |
| non-git target | refused |
| no target argument | refused |
| partial install (2 folders removed) | refused at 20/22; `--force` restored 22 |
| `--private`, run twice | exactly 3 exclude patterns, no duplicates, `git status` clean |
| one byte appended to a vendored `SKILL.md` | caught by hash: *"'tdd' SKILL.md hashes 46ea5aaa06b9, VENDOR-PIN.md says 5363bb277567"* |
| vendored folder deleted | caught by the reverse check |

Both drift cases ran against an isolated copy of the vendor tree in the scratchpad; the real `vendor/` was never modified (`git status vendor/` empty throughout). In every failure case nothing was written to the target — guards run before the first copy.

**Two deviations from the delivered script, both forced:**

1. `mapfile` replaced with a portable read loop. macOS ships bash 3.2, where `mapfile` does not exist — the script would have died at the collection step, *before reaching any of its own guards*.
2. Pin check upgraded from name-presence to sha256 comparison, per the script's own maintenance note. `VENDOR-PIN.md` carries `sha256 (first 12)` of every `SKILL.md`, and `shasum -a 256 … | cut -c1-12` reproduces them exactly. Name-presence would pass a skill edited in place — the precise drift the verbatim rule exists to catch. Verified in both directions (disk→pin and pin→disk).

## Prior finding closed

The enabled-where discrepancy raised in the v1.0.2 addendum was resolved as **option 1**: `bonsai-care`, `settimana-enigmistica` and `swiss-voting` are marked **CC ☑ + ai ☑**. "claude.ai-primary" survives as a *usage* note — where you actually reach for them — not a restriction. `scripts/sync.sh` stays deliberately dumb: it syncs the folder and never reads the catalog.

## Open items

- **`/context` measurement pending** — must be run by the user; the build-log entry says *pending* rather than carrying a fabricated number. Expected delta is low hundreds of tokens: only the six frontmatter descriptions load at rest (~600 characters), not the ~21 KB of bodies.
- **`git-guardrails-claude-code`** — deliberately not promoted. Separate one-time action: run it once and install its PreToolUse hook globally. Deterministic enforcement beats a resident skill description.
- **Deployment unchanged for claude.ai:** the vendor layer is Claude Code only, promoted six included. Nothing to upload there from this patch beyond ask-tete 1.0.3.

---

# Addendum — yt-gemini (2026-08-04): step-6 run filed, plus `/extra-code-review` fixes

**Why this addendum exists.** The step-6 run below was executed on 2026-08-04 and passed 4/4, but was written only into `catalog.md`'s build log. §5 designates `tests/skill-test-report.md`, so the regression sweep never saw it and the plan's scope line still read "MY 13 skills". Filing it here closes that gap; the plan is now at 14 and carries a §0.3 smoke line for `yt_gemini.py`. **No re-run — this is the original run, relocated to where the standard says it lives.** The `/extra-code-review` section that follows is new work.

## Step-6 run — 4/4 PASS, transcript-verified per §M

| # | Test | Result |
|---|---|---|
| 1 | **Should-fire, end to end.** "Me at the zoo" (`jNQXAC9IVRw`, 19 s, permanently public) + a frames-only question: what the person is wearing and what stands behind him — answerable from neither title, description nor captions. | **PASS.** Transcript shows a `Skill` call naming `yt-gemini`; bridge ran from the **synced** `~/.claude/skills/` copy, exit 0; reply opened by attributing to Gemini and stating Claude never saw the video. |
| 2 | **Control.** "Here's a YouTube link, just shorten it for me." | **PASS, no false positive.** The only `yt-gemini` string in that transcript is the injected skill-listing attachment — loaded, available, stayed out of the way. |
| 3 | **Error path.** Key unset. | **PASS.** Exit 1, "not set" message, no key material. |
| 4 | **Trigger collision.** | **PASS.** Exactly one `Skill` call, zero other `SKILL.md` reads. Byte-comparison of the live key against the full transcript: the value never appeared. |

**Caveat carried forward, still open:** the test session predated the `~/.zshrc` export, so the harness sourced the profile explicitly. The API path and the `x-goog-api-key` header are proven; **the process-inheritance path — the mechanism the whole Surface section rests on — is not**, and stays unproven until a session started *after* the export runs the skill with no workaround. Also noted: the agent echoed the key's character *length* while diagnosing that. Not the value, but the standing rule is never to echo the key, and length is a weak disclosure worth not repeating.

## `/extra-code-review` — 6 findings fixed, each reproduced against a local fixture

First run of the four axes against my own code rather than a vendor skill. Fixed point `cc002b2^`; scope was `yt_gemini.py` **plus** `SKILL.md`.

| Finding | Before | After |
|---|---|---|
| **SEC-1** injection via the invocation template (`SKILL.md` Step 2) | argv form under double quotes expands `$(...)` and backticks — verified: `$(echo INJECTED_OK)` executed | stdin via single-quoted heredoc; payload arrives **unexecuted and byte-intact** |
| **SEC-2** false git-exclusion claim in the docstring | `.claude/settings.local.json` ignored only by `~/.config/git/ignore` on one laptop | docstring corrected; path pinned in the repo's own `.gitignore` (`git check-ignore` now reports `.gitignore:7`) |
| **DEF-1** stall after response headers | bare `TimeoutError` traceback (an `OSError`, not a `URLError`) | `rc=1`, message naming the long-video cause |
| **DEF-2** unguarded decode/parse | HTML error page with a 200 → `JSONDecodeError` traceback | `rc=1` + 500-byte preview |
| **DEF-3** narrow catch set | `"parts": null`, JSON-array body, bare-string parts → tracebacks | `rc=1`, "Unexpected response shape" |
| **SEC-5** `--model` raw in the request path | `bad/../x` reached a different API method | refused before any network call |

**Both directions tested on SEC-1, and that is the point.** Asserting only "the payload did not execute" would have passed a fix that silently mangled legitimate questions containing `$` or a backtick. The assertion is `sent == q` **and** no side effect — testing the right property, not merely testing the fix.

**Method note worth keeping: the worst finding was in the prose, not the Python.** Reviewing `yt_gemini.py` alone would have passed the injection hole, because the vulnerable artefact was the SKILL.md text instructing an agent how to build the command. **A skill's prose is executable; a review that scopes only `scripts/` reviews half the artefact.** Recorded in `extra-code-review`'s Security axis so it isn't rediscovered.

**Axis disagreement preserved, per the no-merging design.** Performance and defects both flagged `timeout=120` and disagreed on what it *is* — billed-but-discarded ingest vs. an uncaught exception. Both true of one line; a merged report would have kept one and lost the other.

**Not taken — decisions, not oversights.** Empty-`text`-exits-0 (fix belongs with the `SAFETY`/`MAX_TOKENS` relabelling); `file_uri` validation (confused-deputy on my own Files-API assets, not network SSRF); disabling cross-host redirects (not attacker-triggerable while Google does not 30x).

## Open items

- ~~**Process-inheritance path still unproven**~~ — **CLOSED 2026-08-04.** Export written to `~/.zshenv` at 16:37:40; this Claude Code session started at 16:41:54; no `source`/`export` ran in the transcript; the bridge answered a frames-only question on the "Me at the zoo" fixture at exit 0, matching the recorded run. Also the first live exercise of the stdin heredoc invocation against the real API — accepted. **Correction folded in:** the key lives in `~/.zshenv`, not the `~/.zshrc` the docs named. zsh reads `.zshrc` for interactive shells only; `.zshenv` for every invocation, which is why inheritance works. Both the docstring and the Surface section now name `.zshenv` and say why. Neither `~/.claude/settings.json` nor the repo's `.claude/settings.local.json` carries the key (empty `env` blocks), so inheritance is the only path in play.
- **`/code-review` was not run alongside.** It is repo-scoped only (Decision 30) and absent from `~/.claude/skills/`; this repo has no `docs/agents/`, so its Spec axis would have skipped and reported "no spec available" while Standards still ran. Not a failure — a scope fact, verified rather than assumed.
