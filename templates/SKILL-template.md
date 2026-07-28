---
name: skill-name
description: "PUSHY description: what it does + WHEN to use it, written so the model triggers it. Name concrete situations and paraphrases ('my little ficus looks sick'), not just the domain word. For MANUAL skills keep it short — routing happens by name."
---

# Skill Name

## Purpose
One paragraph: the job this skill does and what 'done' looks like.

## When to use / not use
- Use when: …
- Do NOT use when: … (name the neighboring skill that owns that territory)

## Method
The procedure, as numbered steps or a decision tree. Paraphrase into executable form — never transcribe source material.

## References (progressive disclosure)
Keep SKILL.md <500 lines. Split detail into references/:
- `references/<topic>.md` — loaded only when needed

## Fetch cascade (book-grounded skills only)
For depth: fetch `Skill-Library/<folder>/_summaries/<slug>.md` from Google Drive by filename search (folder browsing doesn't work). Full book only if the summary points deeper. Never trust `modifiedTime` — verify by content.

## Conventions checklist (delete before shipping)
- [ ] Description pushy (auto) or terse (manual)?
- [ ] <500 lines, references split out?
- [ ] Repeats what Claude already knows? Cut it.
- [ ] Any rule better enforced as a deterministic hook than prose?
- [ ] Script instead of prose where deterministic (letter-bank search, etc.)?
- [ ] Catalog entry updated: version, invocation, enabled-where?
