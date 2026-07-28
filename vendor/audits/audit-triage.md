# Audit — triage (read-understand-gap) · @ ed37663 · 2026-07-28

**What:** State machine over tracker items: 2 category roles (bug/enhancement) + 5 state roles (needs-triage/needs-info/ready-for-agent/ready-for-human/wontfix), PRs-as-issues optional (config-gated, external-authors-only discovery). Process per item: gather (incl. REDUNDANCY check against codebase + PRIOR-REJECTION check against .out-of-scope/ KB) → recommend & wait → VERIFY claim (reproduce bug / run PR diff) → grill if needed → apply outcome (agent briefs per AGENT-BRIEF.md; rejected enhancements archived to .out-of-scope/). Every posted comment starts with an AI disclaimer. Quick-override path trusts the maintainer. `disable-model-invocation: true`.
**Deps:** issue-tracker.md + triage-labels.md (setup — labels file written ONLY if triage installed: the detection coupling), grilling, domain-modeling. Two reference docs (AGENT-BRIEF, OUT-OF-SCOPE).
**Security:** clean; the mandatory AI-disclaimer on public comments is a transparency control worth keeping visible.
**Gaps/notes:** (1) .out-of-scope/ is an institutional-memory KB — same philosophy as our 06-decisions-log. (2) The verify-before-grill step (reproduce first) mirrors diagnosing-bugs Phase 1 thinking applied to triage.
**Audit outcome:** clean; no complement material.
