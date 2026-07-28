# Audit — handoff
*Read-understand-gap @ ed37663 · 16 lines · 2026-07-28*

**What:** User-invoked; compacts the conversation into a handoff doc for a fresh agent. Saves to the OS TEMP dir (deliberately not the workspace); includes a "suggested skills" section; references artifacts by path/URL instead of duplicating; explicit redaction rule (keys, passwords, PII); optional argument tailors it to the next session's focus.
**Dependencies:** none. **Security:** clean — the temp-dir write is intentional (keeps repos clean) and the redaction rule is a plus.
**Gaps/notes:** Directly reusable for Project REBORN session transitions, as the dossier predicted. The smart-zone principle in one skill: heavy work continues in a fresh window via this doc rather than a degraded long context.
**Audit outcome:** clean; no complement material.
