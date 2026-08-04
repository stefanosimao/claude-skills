# Mirror Export — repo → Skills Hub project knowledge

*How the claude.ai Skills Hub project gets a copy of three repo files without that copy ever becoming a second source of truth.*

**Why a mirror exists at all.** The repo is private, so a claude.ai session cannot fetch it. With no mirror, the design studio where skills are built is blind to its own inventory. The mirror is the minimum needed to fix that, and nothing more.

**Why it is safe.** It is subordinate *by construction*: every mirrored file carries the commit it was generated from, so a reader can always tell which repo state it reflects and whether that state has moved. Same discipline as `ask-tete`'s `catalog-snapshot.md`. A copy without a stamp is a rival; a copy with one is a photograph.

---

## The three files — and nothing else

| Mirrored | Why it has to be there |
|---|---|
| `catalog.md` | the inventory the Hub is blind without — versions, status, invocation, enabled-where |
| `README.md` | install/usage, so a Hub session can answer "how do I get this on a machine" |
| `docs/skills-hub-plan-v5.2.md` | the plan the Hub project is *for*; it drives the work done there |

**Nothing else gets a second home.** Not the runbook, not the operator's guide, not the library procedures, not the design records. If a Hub session needs one of those, the answer is to read it in the repo on a laptop — not to add a fourth mirrored file. Every addition here is a new thing that can go stale silently.

**Secrets go to neither home.** They live in `~/.zshenv` and nowhere else. The repo being private does not make it a place for credentials, and the mirror is less private than the repo.

---

## Procedure

### 1. Commit first, export second

The stamp names a commit, so the content must already be *in* one. Exporting from a dirty tree produces a stamp that describes something no one else can retrieve.

```bash
git status --porcelain catalog.md README.md docs/skills-hub-plan-v5.2.md   # must be empty
```

Not empty → commit, then come back. Never `--amend` to make a stamp match: a file cannot carry the hash of the commit that contains it, and amending only moves the hash again.

### 2. Generate each stamp from its own file

Each mirrored file is stamped with **that file's** last-touching commit, not `HEAD`. `HEAD` drifts ahead on every unrelated commit, which would age all three mirrors whenever any one of them changed.

```bash
for f in catalog.md README.md docs/skills-hub-plan-v5.2.md; do
  printf '%s\t%s\t%s\n' "$f" "$(git log -1 --format=%h -- "$f")" "$(git log -1 --format=%ad --date=short -- "$f")"
done
```

### 3. Put the banner first — above the H1

It goes on line 1, before the title, so it is the first thing read and survives any preview that truncates. A stamp at the bottom of a long file is a stamp nobody sees.

```markdown
> **DERIVED COPY — do not edit here.** Mirror of `catalog.md` from the private `claude-skills` repo @ `4a245b9` (2026-08-04). The repo is the single source of truth (Decision 34); this copy is **stale unless re-exported**, and edits made here are lost on the next export. Check freshness with `git log -1 --format=%h -- catalog.md` in the repo — a different hash means this file is behind.

# <original title follows unchanged>
```

Then upload to the Hub project's knowledge, replacing the previous version.

### 4. Verify what you uploaded

For each of the three, confirm the hash in the banner equals the repo's current `git log -1 --format=%h -- <file>`. Two of three refreshed is worse than none refreshed, because the untouched one now looks as current as the others.

---

## When to run it

**Trigger: `catalog.md` changed.** That is the same trigger as the `ask-tete` snapshot regeneration, and the two are steps of one action, not two things to remember separately — both answer "something derived is now stale". Both are named together in `skill-forge` step 6.

`README.md` and the plan change rarely; re-export them when they change, on the same trigger check.

**How the mirror goes wrong:** not by being wrong, but by being *plausible*. A four-month-old catalog mirror answers every question confidently and gets versions, statuses and availability all subtly wrong. The stamp is the only thing standing between a reader and that, which is why it goes first and why an unstamped copy is never acceptable.

---

## If this gets run often, script it

The procedure is deliberately manual because it ends in a browser upload no script can perform. If the banner-prepending becomes tedious, the honest shape is `scripts/mirror-export.sh` writing three stamped files into `dist/mirror/` for upload — the same division of labour as `package.sh`, which prepares artefacts and stops at the upload.
