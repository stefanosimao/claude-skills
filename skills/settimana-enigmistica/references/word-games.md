# Word games — letter arithmetic

All of these are Counter operations — use scripts/anagram.py to verify every candidate.

- **Anagramma** — same multiset, new word/phrase. Clue gives lengths ("anagramma: 5 4"). Verify with --check.
- **Scarto** — remove ONE letter (scarto d'iniziale/centrale/finale specifies where) → new word. Verify: candidate fits bank with remainder length 1 at the declared position.
- **Zeppa** — ADD one letter → new word. Reverse of scarto.
- **Cambio** — change exactly one letter (di iniziale/vocale/consonante as declared). Check: same length, Counter diff = one out, one in.
- **Sciarada** — word A + word B (concatenated whole) = word C. The verse clues each part AND the whole. Split C at every seam; test both parts as real words satisfying their clue lines.
- **Incastro** — word A inserted INSIDE word B = C. Test every insertion point.
- **Metatesi / antipodo / bifronte** — adjacent-letter swap / first letter moved to end (or reverse) / word reads as another word backwards. Bifronte check: reverse and look up.

Discipline: the verse's surface meaning misdirects; the LETTER ARITHMETIC is ground truth. When verse and arithmetic disagree, trust the arithmetic.
