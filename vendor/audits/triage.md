# Audit — triage
*Read-understand-gap @ ed37663 · 112 + AGENT-BRIEF.md + OUT-OF-SCOPE.md · 2026-07-28*

**What:** User-invoked Phase-7 state machine over issues (and optionally external PRs = "an issue with attached code"). Two category roles (bug/enhancement) + five states (needs-triage/needs-info/ready-for-agent/ready-for-human/wontfix), exactly one of each per issue. Flow per issue: gather (incl. REDUNDANCY check — search the codebase by domain concept — and PRIOR-REJECTION check vs .out-of-scope/) → recommend & wait → VERIFY the claim (reproduce the bug / run the PR's diff) → grill if needed (grilling + domain-modeling) → apply outcome. ready-for-agent gets an AGENT BRIEF (durable > precise: interfaces & behavior, never file paths/line numbers; complete acceptance criteria; explicit out-of-scope). Rejected enhancements go to the .out-of-scope/ KB (one file per CONCEPT — institutional memory + dedup).
**Hard rule:** every tracker comment starts with the AI-generated disclaimer.
**Dependencies:** tracker + label mapping from setup (hard); grilling, domain-modeling (conditional). **Security:** clean — but note it POSTS PUBLIC comments/labels on real trackers; on work repos, run only where AI-generated comments are acceptable.
**Gaps:** none; AGENT-BRIEF.md is the best writing-for-agents reference in the whole set — reuse its durability principles in our own skills' outputs.
**Audit outcome:** clean; no complement material.
