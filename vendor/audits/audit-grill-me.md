# Audit — grill-me (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** One-line user-invoked wrapper: "Run a /grilling session." `disable-model-invocation: true`.
**Deps:** grilling (hard dependency — must be installed alongside).
**Security:** clean (1 line).
**Gaps/notes:** Exists purely to give the user a slash-command entry point to the auto skill — the user-invoked/model-invoked split applied to a single capability. Copy-the-set rule applies: grill-me without grilling is a dead command.
**Audit outcome:** clean; no complement material.
