#!/usr/bin/env bash
# Package each skill (or a named one) into dist/<name>.zip for claude.ai upload.
# Usage: ./scripts/package.sh [skill-name]
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_DIR/skills"
DIST="$REPO_DIR/dist"
mkdir -p "$DIST"

package_one() {
  local name="$1"
  [[ -d "$SRC/$name" ]] || { echo "  ✗ no such skill: $name"; return 1; }
  rm -f "$DIST/$name.zip"
  (cd "$SRC" && zip -qr "$DIST/$name.zip" "$name")
  echo "  ✓ dist/$name.zip"
}

if [[ -n "${1:-}" ]]; then
  package_one "$1"
else
  for skill in "$SRC"/*/; do package_one "$(basename "$skill")"; done
fi
echo "Done. Upload via claude.ai → Settings → Capabilities → Upload skill."
