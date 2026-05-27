#!/bin/bash
# Local release helper. Runs the full release flow that the GitHub Actions
# workflows used to do on push:
#
#   1. Run scripts/validate.sh on this repo
#   2. Push this repo to origin/main
#   3. (pre-push hook handles the Codex skill sync + commits + pushes Codex)
#
# Usage:
#   bash scripts/release.sh
#
# This is largely a convenience wrapper around `git push` once the pre-push
# hook is installed. The hook does the heavy lifting; this script exists so
# a contributor can verify the same flow without pushing (DRY_RUN=1) and
# to make the order of operations explicit.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

DRY_RUN="${DRY_RUN:-0}"

echo "==> 1/3 Validating valara-claude-plugin..."
bash scripts/validate.sh

CODEX_PLUGIN_DIR="${CODEX_PLUGIN_DIR:-/home/jakep/valara-codex-plugin}"
if [ -d "$CODEX_PLUGIN_DIR/skills" ]; then
  echo "==> 2/3 Pre-syncing skills into Codex plugin..."
  pushd "$CODEX_PLUGIN_DIR" >/dev/null
  bash scripts/sync-from-claude-plugin.sh
  if [ -n "$(git status --porcelain skills/)" ]; then
    echo "    Codex skills will sync on next push (handled by pre-push hook)."
  else
    echo "    Codex skills already in sync."
  fi
  bash scripts/validate.sh
  popd >/dev/null
else
  echo "==> 2/3 WARN: Codex plugin clone not found at $CODEX_PLUGIN_DIR (will skip sync)."
fi

if [ "$DRY_RUN" = "1" ]; then
  echo "==> 3/3 DRY_RUN=1 - skipping git push."
  exit 0
fi

echo "==> 3/3 Pushing valara-claude-plugin to origin/main..."
echo "    (pre-push hook will run validate again + sync Codex + push Codex)"
git push origin main

echo "==> Release complete."
