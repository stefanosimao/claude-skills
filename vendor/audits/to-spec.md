# Audit — to-spec
*Read-understand-gap @ ed37663 · 75 lines · 2026-07-28*

**What:** User-invoked Phase-4 synthesizer: turns the CURRENT conversation into a spec/PRD — explicitly NO interview (grilling's opposite; run grilling first if the thinking isn't done). Sketches test seams (prefer existing, highest possible, ideal count = one) and confirms them with the user; publishes to the tracker with `ready-for-agent`. Template: Problem / Solution / LONG numbered user stories / Implementation Decisions (no file paths — they stale; exception: decision-dense prototype snippets) / Testing Decisions / Out of Scope.
**Dependencies:** tracker + labels from setup (hard); glossary/ADRs (soft); upstream: grilling/prototype produce the conversation it synthesizes.
**Security:** clean. **Gaps:** none — "describe the end state, not the journey" is fully encoded.
**Audit outcome:** clean; no complement material.
