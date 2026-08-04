# claude-skills — house rules

`catalog.md` is canonical (Decision 34). Read its build log before changing anything; don't reconstruct reasoning it already records.

## Reporting work

- **Verify claims, don't assert them — and name the method.** "Executed the hook against all nine patterns" and "read the hook" are different claims with different reliability; reading is what produced a wrong count that then propagated to four documents. A stated method is what makes a claim checkable later. "Verified" without one is just a stronger assertion.
- **Separate what was checked from what was assumed**, explicitly, in the report.
- **Say when a premise doesn't survive contact with the repo** instead of working around it silently. When an instruction and its own later reasoning point in opposite directions, flag it — on 2026-08-04 that happened twice and the reasoning was the better half both times.

## Git

- **Never commit files you didn't author without saying so.** Stage by explicit path when someone else's work is in the tree.
- **`git push` is blocked by a `PreToolUse` hook** (Decision 32). Commit, then ask — never route around it. A commit message that must contain a blocked string goes in a file: `git commit -F <path>`.

## Derived things go stale silently

- A number *computed* from the skill count — `sync.sh`'s `N + 6` folder total, the test plan's scope line and its §0 check — is not a copy of it, so grepping the old count never finds it.
- **`catalog.md` changed → two derived artefacts are now behind:** `ask-tete`'s snapshot and the Hub mirror. One trigger, both consequences — `skill-forge` step 6 and [`docs/mirror-export.md`](docs/mirror-export.md).
- A version label is a claim about content. Content that moves after the label makes the label false, and it stops being harmless the moment the artefact leaves the repo.
