# claude-skills

Source of truth for my Claude Skills. Designed in the **Skills Hub** claude.ai project; distributed from here to every surface.

## Layout

```
claude-skills/
├── catalog.md          ← living inventory: status, version, invocation, enabled-where
├── skills/             ← one folder per skill (SKILL.md + references/)
├── scripts/
│   ├── sync.sh         ← install skills/ → ~/.claude/skills/ (copy or symlink mode)
│   └── package.sh      ← zip each skill into dist/ for claude.ai upload
└── templates/          ← SKILL.md + project-setup templates
```

## Install on a laptop (Claude Code)

One skill:
```bash
npx skills add stefanosimao/claude-skills@<skill-name>
```

Everything (from a clone):
```bash
git pull && ./scripts/sync.sh          # copy mode (default)
git pull && ./scripts/sync.sh --link   # symlink mode
```

Verify: `npx skills list` or ask Claude Code "which skills do you have?"

⚠️ Private repo → `npx skills add` may fail without auth; clone + sync always works.

## Install on claude.ai

Preferred: click **Save skill** when Claude presents the packaged `.skill` file.
Fallback: `./scripts/package.sh` → Settings → Capabilities → Upload skill (delete the old version first when updating). Then toggle it **on**.

Covers cloud sessions, Cowork, and routines automatically — they load whatever is enabled on the account.

## Repo-scoped skills (work projects)

```bash
cp -r skills/<skill-name> <work-repo>/.claude/skills/
```
Repo version wins on name clash; doesn't burn the personal context budget.

## Rules

- Skill work starts and ends in the Skills Hub project; this repo holds the files.
- Matt Pocock's skills (Layer 1) are vendored **verbatim and version-pinned** — never edited. My complements live alongside (Layer 2, `/extra-*` naming).
- Third-party skills are never installed unaudited: clone → line-by-line review → adapt → only then enter this repo.
- After any change: bump version in `catalog.md`, tick the enabled-where boxes, propagate per the release checklist in the operator's guide.
