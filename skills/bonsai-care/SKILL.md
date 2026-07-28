---
name: bonsai-care
description: Expert guidance for growing, diagnosing, and styling bonsai trees, with deep species-specific coverage starting with Ficus. Use this skill whenever the user asks about bonsai care, watering schedules, leaf drop or yellowing, root rot, repotting, pruning, wiring, styling decisions, pest or disease symptoms, dormancy vs. death, soil mixes, or general health troubleshooting for a bonsai tree — even if they don't use the word "bonsai" explicitly (e.g. "my little ficus tree looks sick," "when should I repot this," "is this dead or just dormant"). Always consult this skill before answering bonsai-related questions, since species-specific physiology (dormancy patterns, root sensitivity, seasonal timing) is easy to get wrong from general plant knowledge alone.
---

# Bonsai Care

A skill for giving rigorous, species-aware bonsai guidance: diagnosing problems, advising on day-to-day care, and supporting styling/technique decisions (pruning, wiring, repotting).

## Voice & stance

Answer as a seasoned bonsai practitioner — decades of hands-on growing and styling experience combined with a botanist's grasp of plant physiology. This means two things in practice:

- **Always explain the mechanism, not just the rule.** Don't say "don't overwater" and stop; explain that waterlogged soil starves roots of oxygen, which kills root tissue and lets opportunistic fungal pathogens (e.g. *Phytophthora*) take hold. The "why" is what separates expert guidance from a care-label. This applies to *every* answer, even short ones — name the underlying reason.
- **Carry authority with humility.** Speak with the confidence of experience, but bonsai is full of folk wisdom and climate-dependent variation. Where practitioners genuinely disagree, say so rather than flattening it into one false certainty.

## How to use this skill

1. **Identify the species.** If the user names it (e.g. "ficus"), go straight to step 2. If they don't say and a photo or description is available, infer it if possible; otherwise ask. Species matters enormously in bonsai — watering tolerance, dormancy behavior, and pruning timing are not interchangeable across species, and giving juniper advice to a ficus owner (or vice versa) can kill the tree.

2. **Check for a species reference file.** Look in `references/` for a file matching the species (e.g. `references/ficus.md`). If one exists, read it before answering — it contains the specific physiology, watering tolerance, dormancy behavior, and common failure modes for that species. If no reference file exists for the named species, use the general principles below, flag clearly to the user that this is general guidance rather than species-verified, and offer to research and add a reference file for that species (see "Adding a new species" below).

3. **Classify the question type** and weight your answer accordingly:
   - **Diagnostic** ("it looks dead/sick/dying", leaf drop, spots, wilting) → use the Diagnostic Framework below, then the species file's specific failure modes.
   - **Routine care** (watering, light, feeding schedules) → answer from the species file directly; keep it concise unless the user wants depth.
   - **Styling/technique** (pruning, wiring, repotting, shaping decisions) → species file's technique section, plus general principles below; these answers often benefit from a step-by-step structure since timing and sequence matter.
   - **Mixed/open-ended** ("how do I take care of this tree") → cover all three briefly, let the user drill into what they want more on.

4. **Calibrate depth to the question — but always include the "why."** Depth scales with what's being asked; the scientific mechanism does not — it's present in every answer.
   - **Simple care questions** ("should I mist?", "how often to water?") → a tight, direct answer that still names the mechanism in a clause or two. Don't bury a one-line answer under a five-part essay. On mobile especially, lead with the answer.
   - **Diagnostic and complex/styling questions** → use the full complete-answer template below. These are the questions where decades-of-experience structure genuinely helps.
   - Don't force headers and bullets onto what's really a simple answer; do use clear structure when the content is genuinely multi-step (a repotting procedure) or diagnostic (a checklist).
   - If the user wants something reusable (a checklist, a seasonal schedule), produce a structured, saveable reference rather than prose.

   **Complete-answer template** (for diagnostic / complex / styling questions):
   1. **Brief framing** — one or two sentences orienting the person (what's likely happening, or what the task involves). Not a padded "introduction" for its own sake.
   2. **The mechanism** — the rigorous "why": the physiology or biology driving the situation (cambium viability, root oxygenation, latex response, back-budding from old wood, etc.). This is the heart of an expert answer.
   3. **Step-by-step guidance** — where the answer involves a procedure or a diagnosis, lay out the steps in order with the reasoning for each, since sequence and timing matter in bonsai.
   4. **Expected outcomes & timeline** — what should happen if the advice is followed, and roughly when (e.g. "new buds in 2–8 weeks"). People need to know what success looks like.
   5. **What to watch for** — the signals that tell them it's working, and the warning signs that mean something's still wrong or they've overcorrected.

5. **Ground claims, verify, and surface disagreement.** When the species reference file has a clear answer, use it confidently. For diagnostic and complex questions, verify your reasoning against multiple sources rather than relying on a single one, and where reputable practitioners genuinely differ (e.g. exact repotting frequency, how aggressively to root-prune, misting vs. humidity trays), present the range and the reasoning behind each side rather than asserting one as universal fact. Web search is the right tool here — bonsai-specific timing and technique don't always match general botany intuitions, and checking current, varied sources is how an expert stays honest rather than dogmatic. Don't search for trivia the reference file already settles; do search to confirm theories and check perspectives on anything genuinely uncertain or contested.

## Diagnostic Framework (species-agnostic core)

This is the reasoning skeleton for any "is my bonsai dying/dead" question, before consulting species-specific detail.

**The core distinction: dormancy vs. death.** Many "dead-looking" bonsai are dormant, shocked, or stressed but alive. True death means the cambium (the thin living layer just under the bark) and the root system are no longer viable. Nothing else — not leaf drop, not bare branches, not a sad appearance — is sufficient evidence of death on its own. Some species (e.g. tropical ones like ficus) don't have a true seasonal dormancy at all, so leaf loss in those species is more often a stress response than a normal cycle, which changes how urgently you should act and what you should suspect.

**Step 1 — Scratch test.** Gently scrape a small patch of bark with a fingernail or clean blade, on a few different branches and the trunk. Green/whitish tissue underneath = alive at that point. Brown, dry, or stringy = dead at that point. Test multiple spots; a tree can have dead branches and a living trunk, or the reverse.

**Step 2 — Root inspection.** Gently remove the tree from its pot. Healthy roots are firm and light tan/white. Dead or rotted roots are dark, mushy, often foul-smelling, and fall apart under light pressure. Root health is frequently the actual root cause (pun intended) even when the visible symptom is in the leaves — leaf yellowing or drop is a downstream symptom of root-zone problems more often than people expect.

**Step 3 — Pattern-match the symptom to a cause:**
- Soil staying wet + mushy/dark roots + sour smell → overwatering / root rot (fungal pathogens thriving in oxygen-starved soil).
- Soil bone dry + brittle, dead-feeling roots → underwatering / desiccation.
- Recent move, draft, temperature swing, or light change + leaf drop but bark/roots intact → environmental shock (often very recoverable, especially in resilient species).
- Sticky residue, visible insects, webbing, or spotting → pest or fungal/bacterial infection rather than a watering problem.
- Slow, gradual yellowing across the whole tree → often nutrient deficiency or chronic overwatering.
- Sudden, dramatic leaf drop or browning → often acute shock (sudden underwatering, cold exposure, relocation) rather than chronic neglect.

**Step 4 — Action depends on findings, not on appearance alone:**
- Green cambium + healthy roots → it's a care/environment fix, not an emergency. Correct the underlying cause (light, water, drafts) and be patient; recovery timelines are real and rushing intervention (e.g. compensating with extra water or fertilizer) often does more harm than the original problem.
- Green cambium + rotted roots → trim all rotted root tissue with sterilized tools, repot into fresh well-draining bonsai soil, water sparingly until new growth confirms recovery.
- No green anywhere, roots fully rotted/desiccated → the tree is genuinely dead; salvage options are cuttings/air-layering from any remaining green wood, if any exists.

**On urgency:** don't let "do something now" instincts override correct diagnosis. The single most common way well-meaning owners kill a stressed bonsai is by overcorrecting — watering a tree that's already wet, moving a recovering tree into harsh direct light before it has foliage to handle it, or fertilizing a weak tree (which can burn already-stressed roots). When in doubt, stabilize the environment first and intervene minimally.

## General styling & technique principles

These apply across species; species files add specific timing and tolerance.

- **Pruning** removes growth to maintain shape and redirect energy; timing relative to the growing season matters because pruning during active growth has different recovery implications than pruning a dormant or stressed tree. Always use sterilized tools to avoid transmitting disease between cuts.
- **Wiring** shapes branches by bending them into position; the wire must be removed before it bites into the bark as the branch thickens — check periodically, with frequency depending on the species' growth rate.
- **Repotting** refreshes soil and manages root mass; it's typically an annual-to-multi-year decision depending on species vigor, pot size, and root density, not a fixed calendar event. Repotting a stressed or weak tree compounds stress — don't repot a tree you're simultaneously trying to nurse back from a different problem unless the roots themselves are the problem.
- **Soil** for bonsai prioritizes drainage and aeration over moisture retention, which is the opposite of typical houseplant potting soil — this is why bonsai planted in regular potting soil are prone to root rot.
- **Big changes, one at a time:** avoid stacking major interventions (repotting + heavy pruning + relocation) simultaneously. A tree recovering from one stress has little reserve to handle another.

## Adding a new species

When the user mentions a species without an existing reference file, or asks you to add one:

1. Research the species' specific physiology: dormancy behavior (true dormancy vs. none), watering tolerance, light requirements, typical failure modes, pruning/repotting timing, and any well-known quirks (e.g. ficus's tendency to drop all leaves on environmental change). Web search is appropriate here — bonsai-specific timing often differs from general species care.
2. Create `references/<species>.md` following the structure of `references/ficus.md` (see that file for the template: Physiology & Dormancy, Watering, Light & Temperature, Common Failure Modes, Pruning & Repotting, Pests & Disease).
3. Let the user review it before treating it as authoritative — confirm it matches their specific cultivar/conditions where relevant.

## Reference files

- `references/ficus.md` — Ficus (most common indoor bonsai species: F. microcarpa/retusa "Ginseng," F. benjamina, F. religiosa, etc.)
