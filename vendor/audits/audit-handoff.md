# Audit — handoff (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** Compact the current conversation into a handoff doc for a fresh agent: saved to OS temp dir (NOT the workspace), includes suggested-skills section, references artifacts by path/URL instead of duplicating, redacts secrets/PII, tailors to an argument describing the next session. `disable-model-invocation: true`.
**Deps:** none.
**Security:** clean; explicitly redacts sensitive info — a positive control.
**Gaps/notes:** (1) The smart-zone escape hatch: long context degrades → handoff → fresh session. Also useful for AITeam/REBORN (noted in dossiers). (2) Temp-dir save means handoffs are ephemeral by design; if we ever want durable handoffs, that's a usage convention (pass a path), not a complement.
**Audit outcome:** clean; no complement material.
