# Improve-Mode Audit Checklist

Run top to bottom against the loaded skill; every ✗ becomes a revision item.

1. Invocation mode matches the catalog? (auto skill with terse description under-fires; manual skill with pushy description wastes budget and mis-fires)
2. Description: leading word front-loaded? One trigger per branch? Collision-checked against enabled autos?
3. <500 lines? References split out per the ladder? Pointers worded so they actually fire?
4. Repeats what Claude already knows? → cut.
5. Any rule that should be a deterministic hook instead of prose?
6. Any prose that should be a script?
7. Completion criteria checkable? Exhaustive where it matters?
8. No-op hunt done sentence-by-sentence? Negations rephrased positive?
9. Book-grounded: fetch cascade encoded with exact folder + slug conventions? _sources.md current?
10. Catalog entry: version bumped, enabled-where correct, propagation reminded?
Re-test: rerun the originally-failing prompts plus one should-NOT-fire prompt before shipping.
