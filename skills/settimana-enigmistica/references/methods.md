# Methods & Conventions — per type

## Rebus — reading conventions
- Letters printed in the vignette bind to the NEXT pictured element: `C` + osa (a thing pictured) → COSA. Multiple letters can prefix one object.
- Objects are named in common Italian, singular unless plurality is visually emphatic; people are named by role (re, fante, dama) or action (ara, rema).
- Actions count: a woman sewing = cuce; prefer the verb the scene most plainly shows, 3ª persona singular.
- The **chiave** (e.g. "6 2 8") is law: total letters must match exactly. If the stream doesn't fit, re-read an object (synonym) rather than forcing the cesura.
- First reading (prima lettura) = letters+objects; the solution (frase risolutiva) must be a natural phrase — proverbs, idioms, and definitions are common targets.

## Anagrammi
- Types: anagramma semplice (one word → one word), a frase (letters of a phrase → new phrase), diagram-indicated in the clue by words like *confuso, strano, in disordine, cambiato*.
- Workflow: extract the letter bank (accents normalize: à→a) → run `scripts/anagram.py` with the bank and the target pattern → filter by the clue's definition. Never trust mental anagramming for >8 letters.

## Sciarade & giochi di parole
- sciarada: X + Y = Z, clue defines X, Y, Z in order (order can invert — the verse tells you).
- incastro: X inside Y; scarto: Z = Y minus a letter (scarto d'iniziale/finale/centrale specifies where); cambio: swap exactly one letter (cambio di iniziale/vocale/consonante names which); zeppa: insert one letter.
- Attack: the shortest defined part has the fewest candidates — enumerate it first, propagate.

## Crittografie
- Mnemonica: solution = a phrase that is simultaneously a description of the exposed word and, re-cut by the cesura, the answer. E.g. exposed "AMICI" with chiave 5 4 might resolve to a phrase describing friends that re-reads as something else.
- Conventions: exposed letters may be read as plurals of letter-names (le "i", le "elle"), positions (prima, ultima), or Roman numerals. Punctuation in the exposed text is significant.

## Cruciverba — Italian fill conventions
- Sigle & abbreviations dominate short fill: province (MI, TO, RM), targhe, note musicali (do re mi...), simboli chimici, punti cardinali (N, S, E, O), preposizioni articolate.
- Truncation is licensed: infinitives lose the final -e (andar), poetic forms appear (cor, amor).
- "In mezzo a X" = middle letters of the word X itself; "gli estremi di X" = first+last letters — the clue often operates on its own words.

## Indovinelli
- Two-subject structure: every line true of both the apparent subject and the hidden answer. The title sets the apparent subject.
- Hunt polysemy: penna (feather/pen), vite (life... no — vite screw/vine), collo, radice. List the double-meaning words, intersect their hidden senses.
