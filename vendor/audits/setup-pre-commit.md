# Audit — setup-pre-commit
*Read-understand-gap @ ed37663 · 91 lines · 2026-07-28*

**What:** Scaffolds Husky + lint-staged (Prettier on staged files) + typecheck + test in the pre-commit hook. Detects package manager by lockfile; omits typecheck/test lines when scripts are absent (and says so); creates .prettierrc only if missing; final commit doubles as smoke test of the new hooks.
**Dependencies:** Node ecosystem (husky/lint-staged/prettier) — hard. **Security:** clean; installs three well-known devDependencies, auto-commits at the end (visible, low risk).
**Gaps:** Node-only by design. For Python repos: skip, or use pre-commit(.com) manually — noted, not complement-worthy (settimana-scale niche).
**Audit outcome:** clean; use as-is on JS/TS repos only.
