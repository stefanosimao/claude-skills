#!/usr/bin/env bash
# Sync skills/ → ~/.claude/skills/ (Claude Code personal skills), plus the
# vendor skills promoted to personal scope (PROMOTED_VENDOR below).
# Usage: ./scripts/sync.sh [--link]
#   default: copy mode (safe start)
#   --link : symlink mode (edits in repo apply instantly; a stale repo = stale skills)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_DIR/skills"
VENDOR="$REPO_DIR/vendor/mattpocock"
DEST="$HOME/.claude/skills"
MODE="copy"
[[ "${1:-}" == "--link" ]] && MODE="link"

# Vendor skills promoted to personal CC scope (catalog Decision 30).
# Standalone per their audits — no issue tracker, no docs/agents/, no setup
# dependency — and useful outside a codebase. The other 16 stay repo-scoped:
# copied into a repo's .claude/skills/, never synced account-wide.
PROMOTED_VENDOR=(teach handoff grilling grill-me resolving-merge-conflicts diagnosing-bugs)

in_promoted() {
  local n
  for n in "${PROMOTED_VENDOR[@]}"; do [[ "$n" == "$1" ]] && return 0; done
  return 1
}

# Guards run before anything is written: pin drift must fail loudly, never
# degrade into a quiet partial sync.
for name in "${PROMOTED_VENDOR[@]}"; do
  [[ -d "$VENDOR/$name" ]] || {
    echo "ERROR: promoted vendor skill '$name' is missing from $VENDOR — pin drift?" >&2
    exit 1
  }
done

# A promoted vendor name colliding with one of mine would silently overwrite mine —
# vendor syncs second. No overlap today; the guard is for the day that changes.
for name in "${PROMOTED_VENDOR[@]}"; do
  if [[ -d "$SRC/$name" ]]; then
    echo "ERROR: name clash — '$name' exists in both skills/ and PROMOTED_VENDOR; the vendor copy would overwrite yours." >&2
    exit 1
  fi
done

# grilling (engine) + grill-me (wrapper) ship as a pair; half a pair is a broken skill.
if in_promoted grilling || in_promoted grill-me; then
  { in_promoted grilling && in_promoted grill-me; } || {
    echo "ERROR: grilling and grill-me must be promoted together (engine + wrapper)." >&2
    exit 1
  }
fi

install_skill() {
  local skill="${1%/}" name target
  name="$(basename "$skill")"
  target="$DEST/$name"
  rm -rf "$target"
  if [[ "$MODE" == "link" ]]; then
    ln -s "$skill" "$target"
  else
    cp -r "$skill" "$target"
  fi
  echo "  ✓ $name ($MODE)"
}

mkdir -p "$DEST"

mine=0
for skill in "$SRC"/*/; do
  install_skill "$skill"
  mine=$((mine+1))
done

promoted=0
for name in "${PROMOTED_VENDOR[@]}"; do
  install_skill "$VENDOR/$name"
  promoted=$((promoted+1))
done

echo "Synced $mine skill(s) + $promoted promoted vendor skill(s) → $DEST"
