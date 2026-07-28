# Audit — prototype
*Read-understand-gap @ ed37663 · 26 + 2 ref files · 2026-07-28*

**What:** Model-invoked. A prototype = throwaway code that answers ONE question; the question picks the branch: LOGIC.md (pure state module + minimal TUI shell driven by keystrokes; logic kept portable, TUI disposable) or UI.md (3–5 STRUCTURALLY different variants on one route, ?variant= param + floating switcher, prefer embedding in an existing page over a vacuum route). Shared rules: throwaway from day one, one command to run, no persistence, no polish, surface the state, capture the validated decision into real code and the prototype onto a throwaway branch as a primary source.
**Dependencies:** soft — issue for the capture pointer; project task runner. Consumed by wayfinder (prototype tickets, HITL).
**Security:** clean (NODE_ENV gate on the switcher is defensive).
**Gaps/notes:** UI branch is React/TS-flavored but framework-adapting by instruction. The LOGIC pattern (pure reducer + TUI) is broadly reusable — e.g. for AITeam pipeline dry-runs.
**Audit outcome:** clean; no complement material.
