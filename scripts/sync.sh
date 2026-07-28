#!/usr/bin/env bash
# Sync skills/ → ~/.claude/skills/ (Claude Code personal skills).
# Usage: ./scripts/sync.sh [--link]
#   default: copy mode (safe start)
#   --link : symlink mode (edits in repo apply instantly; a stale repo = stale skills)
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_DIR/skills"
DEST="$HOME/.claude/skills"
MODE="copy"
[[ "${1:-}" == "--link" ]] && MODE="link"

mkdir -p "$DEST"
count=0
for skill in "$SRC"/*/; do
  name="$(basename "$skill")"
  target="$DEST/$name"
  rm -rf "$target"
  if [[ "$MODE" == "link" ]]; then
    ln -s "${skill%/}" "$target"
  else
    cp -r "$skill" "$target"
  fi
  count=$((count+1))
  echo "  ✓ $name ($MODE)"
done
echo "Synced $count skill(s) → $DEST"
