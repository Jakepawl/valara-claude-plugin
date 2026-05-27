#!/bin/bash
# One-time installer that points this repo's git hooks at the versioned
# .githooks/ directory (so the pre-push hook lives in git history rather
# than under .git/hooks/ which is local-only).
#
# Run once per clone:
#   bash scripts/install-hooks.sh

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

git config core.hooksPath .githooks
chmod +x .githooks/* 2>/dev/null || true

echo "Git hooks now point at .githooks/"
echo "Pre-push will run scripts/validate.sh + (when skill changes) sync to valara-codex-plugin."
echo ""
echo "Override CODEX_PLUGIN_DIR env var if your Codex plugin clone lives elsewhere."
echo "Bypass the hook for one push: git push --no-verify (NOT RECOMMENDED)."
