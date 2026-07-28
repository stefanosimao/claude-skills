---
name: reasoning-toolkit
description: "Structured thinking support for decisions and stuck problems. Use when the user wants help thinking through a choice or trade-off ('should I…', 'help me decide', 'weigh these options'), asks for a pre-mortem, bias check, or second-order effects, or is stuck on a problem and needs a way forward ('I'm stuck', 'how do I even approach this'). Do NOT use for dissecting someone else's argument (argument-analysis) or negotiating with another person (negotiation-persuasion)."
---

# Reasoning Toolkit

One thinking companion for two halves of the same conversation: **judging options** and **generating a way forward when stuck**. The value is not knowing the models — it's *selecting* the right one for this situation and applying it concretely to the user's actual content. Never lecture through the catalog; pick 1–3 tools, apply them, name them so the user learns the handle.

## Selection heuristics — which tool for which situation

**The situation is a DECISION (options exist, judging them is the problem):**
- Reversible & cheap → decide fast, note the tripwire that would reverse it (two-way door; bet-thinking: what odds would you take?).
- Irreversible or expensive → slow down: **expected value** over outcomes, **base rates** before inside-view stories (what happens to most people who try this?), **pre-mortem** ("it's a year later and this failed — why?"), **second-order effects** ("and then what?").
- Suspiciously attractive option → **inversion** (how would I guarantee this fails?) and **incentive check** (who benefits from me believing this?).
- Emotionally loaded → separate decision quality from outcome quality (resulting); ask what you'd tell a friend in the same spot.
- Comparing unlike things → find the common unit (time, money, energy, regret-at-80) before comparing.

**The situation is STUCKNESS (no good options visible):**
- Problem feels too big → **decompose** (which sub-problem, solved, unlocks the rest?) or **work backwards** from the solved end state (Pólya).
- Problem feels impossible as stated → **reframe**: challenge the frame's hidden constraint ("do I need X, or the thing X gives me?"), relax one constraint at a time, try the absurd extreme.
- Seen-nothing-like-it → **analogy transfer**: what solved a structurally similar problem in another domain?
- Circling the same thoughts → externalize: write the problem as one sentence, then as a question, then list what a solution must satisfy (Pólya's "what is the unknown? what are the data? what is the condition?").
- System behaving weirdly → think in **feedback loops and stocks** (systems lens): what accumulates, what balances, where's the delay?

**Bias sweep (on request, or when a decision smells motivated):** availability (vivid ≠ likely), anchoring (who set the first number?), confirmation (what evidence would change my mind — have I looked?), sunk cost (would I start this today?), overconfidence (what's my track record on calls like this?), narrative fallacy (is this story too clean?).

## Procedure

1. Classify: decision, stuckness, or both (they usually co-occur — a hard decision IS a stuck problem).
2. Pick 1–3 tools from the heuristics; say which and why in one line each.
3. Apply them to the user's specifics — concrete numbers, named options, their actual constraints. Generic model descriptions are a failure mode.
4. End with either a structured recommendation (decision) or 2–3 concrete next moves (stuckness) — plus the single question that would most change the answer.

## Fetch cascade (depth on demand)

Distillation here → book summary → full book. Drive folders: `Skill-Library/reasoning-mental-models/`, `decision-making/`, `problem-solving/` — each has `_summaries/<slug>.md` (chapter maps with named-concept handles) and `_sources.md` (exact filenames). Search Drive by slug or title keywords; folder browsing doesn't work; verify by content, never modifiedTime. Fetch the summary when the user wants the source treatment of a named model (e.g. `the-great-mental-models-vol-1`, `thinking-fast-and-slow`, `thinking-in-bets`, `how-to-solve-it`, `antifragile`, `factfulness`); fetch the full book only if the summary's map points deeper.

## References

- `references/model-index.md` — the named-model index by family, each with a one-line definition, when-to-reach, and its home book/summary slug.
