# Operator's Guide — From GitHub Repo to Installed Skills (v3.2)

*My step-by-step manual for the manual parts: everything Claude can't do for me.*

**v3.2 changes (2026-08-04, on import to the repo):** the expected sync output was **13 + 6 → 19 folders**, stale since `yt-gemini` made the catalog 14 — corrected to **14 + 6 = 20** in §2 and §7. This is a *derived* number: it is computed from the skill count, not a copy of it, so a search for "13" never finds it. The "Laptop B" checklist line is gone — machine currency is a procedure ([`new-machine-setup.md`](new-machine-setup.md)), never a per-laptop checkbox. The project-knowledge mirror step now points at [`mirror-export.md`](mirror-export.md), which defines what may be mirrored and how it is stamped.

**v3.1 changes (vendor validation 2026-08-03, both tiers, zero ENV findings):** §4 gains the branch-before-implement rule, the local-tracker "done" convention, and the diagnosing-bugs trigger rule; new §6 for headless/automated runs (harness flags); troubleshooting gains the phantom-failure and never-red-tests entries. v3 content otherwise unchanged.

---

## 0. One-time setup (per laptop)

```bash
git clone https://github.com/stefanosimao/claude-skills.git
cd claude-skills
chmod +x scripts/*.sh        # exec bit doesn't survive some transfers
```

## 1. Adding or updating a skill (the release cycle)

1. Finish the skill with Claude in the Skills Hub project → download the folder (and `.skill` file).
2. `cp -r ~/Downloads/<skill-name> skills/` → commit → **push immediately** (unpushed commits on one disk are the single biggest risk).
3. Update `catalog.md`: version, status, invocation, enabled-where. **If catalog.md changed, regenerate ask-tete's `references/catalog-snapshot.md`** (stamp = catalog.md's last-touching commit, never `--amend`).

## 2. Install on a laptop (Claude Code)

```bash
git pull && ./scripts/sync.sh        # --link for symlink mode
```

Expected: **"14 skill(s) + 6 promoted vendor skill(s)"** → 20 folders in `~/.claude/skills/`. Verify with `/context` against the catalog ledger (~3.4k / 0.3%). **Both numbers are derived from the skill count** — when `skills/` changes, this line and §7's checklist change with it, and grepping the old count will not find them.

Single skill: `npx skills add stefanosimao/claude-skills@<name>`.

## 3. Install on claude.ai (web / mobile / desktop)

**A:** Save-skill on a packaged `.skill`. **B:** `./scripts/package.sh <name>` → Settings → Capabilities → Upload. **Delete the old version first when updating.** Toggle on. Covers cloud sessions, Cowork, routines.

⚠️ Vendor skills never go to claude.ai. ask-tete there always lists from its snapshot — the staleness caveat is by design.

## 4. Vendor pipeline into a repo

```bash
~/claude-skills/scripts/install-vendor.sh <repo>              # shared: commit → team + cloud
~/claude-skills/scripts/install-vendor.sh --private <repo>    # laptop-only: git-excluded, no cloud
```

Enforced by the script: whole-set install, sha256 pin verification both directions, partial-guard (`--force` to replace), `--private` exclude entries.

After installing, in that repo:
1. `/setup-matt-pocock-skills` **once** before any pipeline skill. It reads the environment first — no git remote → it will recommend **local-markdown** (zero external deps, the work-laptop mode; validated 2026-08-03: it reached that recommendation itself).
2. Shared mode: `git add .claude/skills && git commit` — cloud sessions only see committed skills.
3. ⚠️ Public/work repos with the GitHub tracker: `triage` **creates labels and posts public AI-disclaimed comments** — confirm acceptable before first use (live example: TRMNL-ZH is public with issues enabled).

**Using the pipeline — three rules the tests taught:**
- **Branch before `/implement`.** The skill commits to the *current* branch by contract (`implement/SKILL.md`: "commit your work to the current branch") — it does not branch for you. Create the feature branch first, or accept commits where you stand.
- **Say "debug this" (or invoke `diagnosing-bugs` by name) when you want the diagnosis discipline.** Symptom-only phrasing ("this returns wrong results, help") fired it ~1/6 across all probes; a trigger word fired it 2/2. The difference is material: when it fires, the fix arrives with a test that was red first; when it doesn't, you get a correct fix and tests written *after* — green tests never shown able to fail (exactly the defect the extra-code-review mutation check catches).
- **Local-markdown tracker has no "done" state.** The five canonical labels end at ready-for-agent/ready-for-human. Convention: when a ticket ships, edit its `Status:` line to `done — <commit>` by hand (or accept that shipped tickets sit at ready-for-agent; on GitHub this is a non-issue, closing is native).

## 5. One-time: git-guardrails hook (per laptop)

```bash
cd ~/claude-skills && claude
> /git-guardrails-claude-code        # choose GLOBAL scope
```

(Fallback: temp-copy to `~/.claude/skills/`, run, delete.) Verify: a `git reset --hard` request gets blocked; `~/.claude/settings.json` shows the PreToolUse entry. Repeat per laptop; hooks don't propagate.

## 6. Headless / automated runs (`claude -p`)

Learned running the vendor tests; applies to any scripted use:
- **Always pass** `--permission-mode acceptEdits --allowedTools "Bash,Write,Edit,Read,Glob,Grep,Skill,TodoWrite"` (trim to need). Default headless mode auto-denies every permission prompt — write-capable skills then look broken when they aren't.
- **Append `< /dev/null`** when a heredoc precedes `claude -p` in the same command — otherwise the CLI swallows stdin and stalls ~3s.
- `/grill-me`, `/teach`, `/handoff` are `disable-model-invocation: true`: they never appear in a session's skill list and are reachable only as typed slash commands — absence from a listing is not a missing install.

## 7. Release checklist (per changed skill)

- [ ] Folder committed, version bumped in catalog, **pushed**
- [ ] catalog.md changed? → snapshot regenerated (ask-tete patch-bumped)
- [ ] Each machine in use: `git pull && ./scripts/sync.sh` (expect 14 + 6 = 20). A machine that has never been set up needs [`new-machine-setup.md`](new-machine-setup.md), not the pull
- [ ] claude.ai: re-upload (delete old first) — only if enabled there
- [ ] Uploaded? Record which skills went up at which versions in the catalog build log — **the artefact carries no version**, so that entry is the only record of what is live
- [ ] `/context` → ledger updated on meaningful change
- [ ] Catalog: enabled-where ticked; 🧪→✅ only when installs are real
- [ ] catalog.md changed? → ask-tete snapshot regenerated **and** the Hub mirror re-exported ([`mirror-export.md`](mirror-export.md))

## 8. Troubleshooting

| Symptom | Likely cause → fix |
|---|---|
| Skill never triggers | Description not pushy enough; OR budget overflow (`/context` vs ledger); OR task too simple → invoke explicitly |
| diagnosing-bugs silent on a bug report | Symptom-only phrasing → say "debug this" or invoke by name (§4) |
| Headless run: every skill "fails" to write/run | Missing `--permission-mode acceptEdits` + `--allowedTools` (§6) |
| Skill "missing" from a session's skill list | If grill-me/teach/handoff: normal — disable-model-invocation (§6). Else: not synced/enabled |
| Tests green but suspicious | Were they ever red? Post-fix tests never shown failing → run /extra-code-review (mutation check) |
| Skill missing in cloud session | Not enabled on claude.ai; or repo skills not **committed** (`--private` never reaches cloud) |
| `sync.sh` aborts: promoted vendor missing / name collision | Pin drift → `git pull`; collision → rename yours |
| `install-vendor.sh` refuses: pin drift / partial install | Restore verbatim from git / `--force` wholesale replace |
| Pipeline skills guess where issues live | `/setup-matt-pocock-skills` never ran there |
| `implement` committed to main | It commits to the *current* branch — branch first (§4) |
| ask-tete listing "may be stale" | Normal outside the repo — snapshot path |
| `Permission denied` on scripts | `chmod +x scripts/*.sh` |
