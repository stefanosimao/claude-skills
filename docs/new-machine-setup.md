# New machine setup

*Ordered runbook for bringing any machine current with this repo. Written 2026-08-04, replacing the per-laptop state items that used to sit in the deployment queue. **A machine is either current or it is not** — that is a property you check by running this, never a checkbox someone else maintains on your behalf.*

## Why this file exists

Tracking "Laptop B is behind" as a queue item made a *state* claim that rots the moment anyone touches either machine, and it blocked unrelated work — the 🧪→✅ sweep sat waiting on a machine that might never be opened. A runbook has neither problem: it is correct whether you have one machine or five, it never goes stale by sitting still, and nothing else waits on it.

## What does NOT travel with the repo

`git pull` brings the repo. It does not bring any of the following, because **they live outside the working tree by design** — this is the entire reason a per-machine runbook is needed:

| Thing | Where it lives | Consequence |
|---|---|---|
| Shell profile / API keys | `~/.zshenv` | Secrets must never be in the repo; each machine exports its own. |
| Claude Code hooks | `~/.claude/settings.json` + `~/.claude/hooks/` | Guardrails do **not** propagate. A machine without step 4 has no brake. |
| Account-wide skills | `~/.claude/skills/` | Written by `scripts/sync.sh`; the repo's `skills/` is the source, this is the install. |

Corollary worth stating once: **there is no single source of truth across machines for any row in that table.** Editing the hook's pattern list on one machine leaves the other unchanged and silently divergent. If you change any of them deliberately, change them everywhere or record the divergence.

## Steps

### 1. Clone

```bash
git clone <remote> ~/claude-skills && cd ~/claude-skills
```

### 2. Export the API key in `~/.zshenv`

```bash
export GEMINI_API_KEY="…"
```

**`~/.zshenv`, not `~/.zshrc`.** `~/.zshrc` is sourced only for *interactive* shells; the shells Claude Code spawns for tool calls are non-interactive, so a key exported there is invisible exactly where `yt-gemini` needs it. This cost a failed inheritance check once — the diagnosing session had to source the profile explicitly as a workaround, which proved the API path but left the inheritance mechanism itself unproven.

**Verify without ever echoing the value:**

```bash
[ -n "$GEMINI_API_KEY" ] && echo "SET" || echo "NOT SET"
```

Never echo the key, and **never echo its length either** — length is a weak disclosure and the standing rule is that the value does not enter the transcript. Confirmed working on Laptop A 2026-08-04: a session started after the export had the key by inheritance, no workaround.

### 3. Sync skills

```bash
./scripts/sync.sh
```

**Expect `Synced 14 skill(s) + 6 promoted vendor skill(s)` — 20 folders in `~/.claude/skills/`.** A different count means either the catalog moved or `sync.sh` hit a guard; read the error rather than re-running. The script aborts loudly on pin drift (a promoted vendor skill missing from `vendor/`), on a name clash between `skills/` and `PROMOTED_VENDOR`, and if `grilling`/`grill-me` are split.

**Verify the copies are current, not merely present** — existence is not freshness:

```bash
cd skills && for s in *; do diff -rq "$s" ~/.claude/skills/"$s" >/dev/null || echo "STALE: $s"; done
```

### 4. Install git guardrails

Run `/git-guardrails-claude-code`, choose **global scope** (`~/.claude/settings.json`), keep the **default nine-pattern set**. Per Decision 32 this is a hook rather than a resident skill, so it fires on the tool call without the model's cooperation and costs zero resting context.

Verify both ways — registration *and* live behaviour:

```bash
grep -A9 PreToolUse ~/.claude/settings.json     # hook is registered
```

Then attempt a `git reset --hard` **on a confirmed-clean tree** and expect exit 2 with a `BLOCKED:` message. Check the tree first: testing a guardrail means deliberately performing the dangerous operation, so the order is confirm-nothing-at-risk, *then* attempt. If the hook silently failed to install, the test itself is the accident it was meant to prevent.

**Know the coverage boundary before you rely on it** (measured 2026-08-04, not assumed). Patterns match as substrings anywhere in the command. Seven of the nine carry a literal `git ` prefix; only `reset --hard` and `push --force` stand alone. So `git -C /other/repo reset --hard` is caught, but `git -C /other/repo push`, `… clean -fd`, `… clean -f`, `… branch -D`, `… checkout .` and `… restore .` **all get through** — six of the seven — because the `-C <path>` form breaks the `git `-adjacency they depend on. `reset --hard` is the only prefixed pattern that survives the rewrite, and only because it stands alone as well. `cd /other && git push` is still caught. **This is a brake on the command you would type by habit, not a containment boundary**: it stops the accident, not an adversary. The bluntness is deliberate — a matcher clever enough to parse intent is also clever enough to be talked around — and the price is false positives, e.g. a `grep` whose *search string* contains `git push` gets blocked. Rephrase and move on.

If the settings file already had content, the skill merges rather than overwrites and leaves `~/.claude/settings.json.bak`.

### 5. Per pipeline repo: vendor install, then setup

Inside each repo that runs the pipeline:

```bash
./scripts/install-vendor.sh          # whole-set only, sha256 pin-verified both directions
```

Then invoke `/setup-matt-pocock-skills` **once, in that repo**. Per Decision 31 this is *the* vendor distribution path; it refuses partial sets by design. `--private` installs git-excluded and laptop-only, and is mutually exclusive with cloud sessions by mechanism — cloud loads only skills committed to `.claude/skills/`, so a git-excluded skill is invisible there. Note `implement` commits to the *current* branch by contract: branch first.

### 6. Baseline context audit

Run `/context` and append the reading to the **Context audit ledger** in `catalog.md`, stamped with the machine, date, Claude Code version and model — the existing entries are provenance records, so match their shape. This is the one step whose output belongs in the repo; everything above it is machine-local.

## Surfaces this runbook does not reach

`sync.sh` writes to `~/.claude/skills/` on a *local* machine. **Cloud sessions and Claude Code on the web load only skills committed to a repo's `.claude/skills/`**, so nothing installed by step 3 exists there, and `yt-gemini` additionally cannot run there for two further independent reasons (no network egress from claude.ai's sandbox; no secrets store on cloud). See the `yt-gemini` row in `catalog.md` — the three limits do not collapse into one.
