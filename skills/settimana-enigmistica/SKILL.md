---
name: settimana-enigmistica
description: "Solving methods for Italian puzzle types — rebus, anagrammi, sciarade, crittografie, cruciverba, indovinelli. Invoke by name; photo of the page works as input."
---

# Settimana Enigmistica

Solving methods per puzzle type, with Italian wordplay conventions. Input is usually a photo of the page — read the puzzle from the image first, transcribing the clue, the diagram/letter counts, and any given letters, and confirm the reading before solving.

## Route by type

- **Rebus** → `references/rebus.md` — reading conventions (letters shown + things depicted read in sequence), the cesura (how "FRASE: 4, 7" splits), grafemi vs figure.
- **Anagrammi / scarti / cambi / zeppe** → `references/word-games.md` + the letter-bank script (below). These are LETTER-ARITHMETIC puzzles: solving by vibes fails; solve by counting.
- **Sciarade / incastri** → word-games.md — word A + word B = word C mechanics, syllable seams.
- **Crittografie** (mnemoniche, sinonimiche…) → `references/crittografie.md` — the double-reading discipline: the solution phrase must read BOTH as answer to the exposed clue AND as the letter-count pattern.
- **Cruciverba** → crossing-first strategy: fill high-crossing entries, prefer Italian crosswordese (short words, common suffixes), verify every crossing before committing a long entry.
- **Indovinelli** — the classic double meaning: the poem describes an apparent subject; the answer is a different word satisfying every line literally. Solve by listing each line's constraints, then intersecting.

## Scripts over prose (anagram work)

For anagrammi and letter-arithmetic, USE THE SCRIPT — deterministic letter-bank search beats prose reasoning:
`python3 scripts/anagram.py "<letters>" [--wordlist path] [--min N]` — sorts and matches letter multisets; `--sub` finds words inside the bank (for scarti/zeppe). With no Italian wordlist on the machine, the script still verifies candidate ↔ bank equality — use it to CHECK every proposed anagram before presenting it. Never present an anagram unverified.

## Conventions & honesty

- Numbers in clues are letter counts of the solution words — always reconcile the final answer against them; a solution that doesn't match the counts is wrong, full stop.
- Italian conventions: no accents in grids (perche' → PERCHE), qu counts as two letters, answers in the clue's register.
- When stuck, say which constraint is unsatisfied rather than forcing a poor fit; offer the two best partials.
