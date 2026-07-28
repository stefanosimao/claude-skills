#!/usr/bin/env bash
set -euo pipefail

# install-vendor.sh — install the Matt Pocock vendor set (whole, verbatim) into a repo's .claude/skills/
#
# Usage:
#   install-vendor.sh <target-repo>             # shared mode: skills meant to be committed (team + cloud sessions get them)
#   install-vendor.sh --private <target-repo>   # private mode: same copy, but git-excluded locally (laptop-only; cloud never sees them)
#   install-vendor.sh --force ...               # allow overwriting an existing partial/older install
#
# Rules encoded (from the vendor audits — do not bypass):
#   * The set installs WHOLE. Skills detect each other (e.g. setup checks for triage); partial copies make detection lie.
#   * Pin discipline: refuses to install if the vendor tree disagrees with VENDOR-PIN.md.
#   * After installing: run /setup-matt-pocock-skills ONCE in the target repo before any pipeline skill.
#
# Note: six of these skills (teach, handoff, grilling, grill-me, resolving-merge-conflicts,
# diagnosing-bugs) are also promoted to personal scope by sync.sh — you do not need this
# script just for those. The set still installs whole here; repo-scoped copies win on name clash.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
VENDOR_DIR="$REPO_ROOT/vendor/mattpocock"
PIN_FILE="$VENDOR_DIR/VENDOR-PIN.md"

PRIVATE=0
FORCE=0
TARGET=""

for arg in "$@"; do
  case "$arg" in
    --private) PRIVATE=1 ;;
    --force)   FORCE=1 ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)         TARGET="$arg" ;;
  esac
done

fail() { echo "ERROR: $*" >&2; exit 1; }

# sha256, first 12 hex chars — the form VENDOR-PIN.md records.
sha12() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | cut -c1-12
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | cut -c1-12
  else
    fail "neither shasum nor sha256sum is available — cannot verify the pin"
  fi
}

# The pin table's rows are: | vendored-as | original path | files | `sha256(12)` |
pin_hash_for() {
  awk -F'|' -v want="$1" '
    NF >= 6 {
      name = $2; hash = $5
      gsub(/^[ \t]+|[ \t]+$/, "", name)
      gsub(/[ \t`]/, "", hash)
      if (name == want && hash ~ /^[0-9a-f]{12}$/) { print hash; exit }
    }' "$PIN_FILE"
}

pin_names() {
  awk -F'|' '
    NF >= 6 {
      name = $2; hash = $5
      gsub(/^[ \t]+|[ \t]+$/, "", name)
      gsub(/[ \t`]/, "", hash)
      if (hash ~ /^[0-9a-f]{12}$/) print name
    }' "$PIN_FILE"
}

[ -n "$TARGET" ] || fail "no target repo given. Usage: install-vendor.sh [--private] [--force] <target-repo>"
[ -d "$VENDOR_DIR" ] || fail "vendor layer not found at $VENDOR_DIR — is this script inside the claude-skills clone?"
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || fail "target repo does not exist"
[ -d "$TARGET/.git" ] || fail "$TARGET is not a git repository (no .git). Private mode needs .git/info/exclude; shared mode needs commits."

# --- Collect the set ------------------------------------------------------
# Portable read loop rather than mapfile: macOS ships bash 3.2, where mapfile does not exist.
SKILLS=()
while IFS= read -r dir; do
  SKILLS+=("$(basename "$dir")")
done < <(find "$VENDOR_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
[ "${#SKILLS[@]}" -gt 0 ] || fail "vendor/mattpocock/ contains no skill folders"

# --- Pin verification -----------------------------------------------------
# VENDOR-PIN.md carries the sha256 of every SKILL.md, so verify CONTENT, both directions.
# Name presence alone would pass a skill edited in place — the exact drift the
# verbatim rule exists to catch.
[ -f "$PIN_FILE" ] || fail "VENDOR-PIN.md missing — refusing to install an unpinned vendor set"

for s in "${SKILLS[@]}"; do
  expected="$(pin_hash_for "$s")"
  [ -n "$expected" ] || fail "pin drift: '$s' on disk but not in VENDOR-PIN.md — re-audit before installing"
  [ -f "$VENDOR_DIR/$s/SKILL.md" ] || fail "pin drift: '$s' has no SKILL.md — the vendor tree is corrupt"
  actual="$(sha12 "$VENDOR_DIR/$s/SKILL.md")"
  [ "$actual" = "$expected" ] || fail "pin drift: '$s' SKILL.md hashes $actual, VENDOR-PIN.md says $expected — the set is edited or stale. Re-audit + pin bump before installing."
done

while IFS= read -r pinned; do
  [ -d "$VENDOR_DIR/$pinned" ] || fail "pin drift: VENDOR-PIN.md lists '$pinned' but the folder is missing — the set is incomplete"
done < <(pin_names)

echo "Pin verified: ${#SKILLS[@]} skills match VENDOR-PIN.md (sha256 of each SKILL.md)"

# --- Partial-install guard ------------------------------------------------
DEST="$TARGET/.claude/skills"
if [ -d "$DEST" ] && [ "$FORCE" -ne 1 ]; then
  EXISTING=$(find "$DEST" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')
  if [ "$EXISTING" -gt 0 ]; then
    PRESENT=0
    for s in "${SKILLS[@]}"; do [ -d "$DEST/$s" ] && PRESENT=$((PRESENT+1)); done
    if [ "$PRESENT" -gt 0 ] && [ "$PRESENT" -lt "${#SKILLS[@]}" ]; then
      fail "partial vendor install detected in $DEST ($PRESENT/${#SKILLS[@]} skills). Partial sets lie to each other. Re-run with --force to replace the vendor skills wholesale."
    fi
  fi
fi

# --- Copy the whole set ---------------------------------------------------
mkdir -p "$DEST"
for s in "${SKILLS[@]}"; do
  rm -rf "$DEST/$s"
  cp -R "$VENDOR_DIR/$s" "$DEST/$s"
done
echo "Installed ${#SKILLS[@]} vendor skills → $DEST"

# --- Private mode: keep everything off the remote -------------------------
if [ "$PRIVATE" -eq 1 ]; then
  EXCLUDE="$TARGET/.git/info/exclude"
  mkdir -p "$(dirname "$EXCLUDE")"; touch "$EXCLUDE"
  for pattern in ".claude/skills/" "docs/agents/" ".scratch/"; do
    grep -qxF "$pattern" "$EXCLUDE" || echo "$pattern" >> "$EXCLUDE"
  done
  echo "Private mode: .claude/skills/, docs/agents/, .scratch/ added to .git/info/exclude (local clone only — nothing reaches the remote; cloud sessions will NOT have these skills)"
else
  echo "Shared mode: commit the skills to share them with the team and cloud sessions:"
  echo "  cd $TARGET && git add .claude/skills && git commit -m 'Add engineering pipeline skills (pinned vendor set)'"
fi

# --- Reminders ------------------------------------------------------------
cat <<'EOF'

NEXT STEPS — do not skip:
  1. Run /setup-matt-pocock-skills ONCE in the target repo before any pipeline skill
     (configures issue tracker [GitHub/GitLab/local-markdown], triage labels, docs layout).
  2. On work repos: 'triage' posts PUBLIC AI-disclaimed comments — confirm that's acceptable there.
EOF
