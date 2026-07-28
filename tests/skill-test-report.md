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
