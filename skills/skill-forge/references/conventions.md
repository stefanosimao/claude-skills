# Drafting Conventions

*Distilled from Anthropic's skill-creator and Matt Pocock's writing-great-skills (kept as external reference at vendor source; principles adapted here).*

## Root virtue: predictability
A skill wrangles determinism out of a stochastic system. Same PROCESS every run — not same output.

## Invocation economics
- Model-invoked: description sits in the window every turn (context load) but the agent and other skills can reach it.
- User-invoked: zero context load, but the user pays cognitive load — they must remember it exists. Router skill (ask-tete) is the cure when manuals multiply.
- Pick model-invocation only when the agent must reach it on its own or another skill must.

## Descriptions
- Front-load the leading word. One trigger per genuinely distinct branch; synonyms of one branch = duplication, collapse them.
- Auto descriptions: rich trigger phrasing ("Use when the user wants…, mentions…"). Manual descriptions: one human-facing line.

## Information hierarchy (the ladder)
1. In-skill STEP — ordered action, ends on a CHECKABLE completion criterion (vague criteria invite premature completion).
2. In-skill REFERENCE — rules/definitions consulted on demand; a flat peer-set is fine.
3. External reference — pushed to `references/<topic>.md`, reached by a context pointer whose WORDING decides whether it fires.
Progressive disclosure = moving down the ladder so SKILL.md stays legible (<500 lines). Branch test: inline what every branch needs; disclose what only some branches reach. Co-locate a concept's definition + rules + caveats under one heading.

## Leading words
A compact pretrained concept the agent thinks with (tracer bullet, fog of war, tight, red). It anchors execution in the body and invocation in the description. Hunt restatements ("fast, deterministic, low-overhead" → *tight*) and collapse them.

## Failure modes to hunt on every pass
- **Premature completion** — sharpen the completion criterion first; split the sequence only if the rush persists.
- **Duplication** — one meaning, one place (single source of truth).
- **Sediment** — stale layers; pruning is a discipline, not an event.
- **Sprawl** — every line live but the skill too long; cure with the ladder.
- **No-op** — a line the model obeys by default; the test: does it change behavior vs default? Delete the sentence, don't trim it.
- **Negation** — "don't do X" makes X more available; state the positive target; keep prohibitions only as unphrasable-positively guardrails, paired with the alternative.

## House additions
- Scripts over prose where the operation is deterministic (letter-bank search, checksum, diff) — a script is a better tool, not decoration.
- Hooks over prose where enforcement must be certain (the git-guardrails pattern): CLAUDE.md instructions are non-deterministic; PreToolUse hooks are not.
- Repeats-what-Claude-knows test: content restating general model knowledge is a no-op at skill scale — the value is MY canon, MY conventions, MY data.
