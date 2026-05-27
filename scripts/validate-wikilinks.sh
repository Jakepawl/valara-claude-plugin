#!/usr/bin/env bash
set -euo pipefail

# Verify every [[skill-name]] wikilink points to a real skill or command.
#
# Uses bash 4+ features (BASH_REMATCH from the [[ =~ ]] operator). macOS
# ships bash 3.2.x at /bin/bash which lacks reliable BASH_REMATCH; the
# /usr/bin/env shebang plus the version check below catch the gap.

if [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
  echo "FAIL: validate-wikilinks.sh requires bash 4 or newer (have ${BASH_VERSION:-unknown})." >&2
  echo "      On macOS, install Homebrew bash (brew install bash) and re-run." >&2
  exit 1
fi

cd "$(dirname "$0")/.."

FAIL=0
# Collect known skill + command names from filesystem
KNOWN=$(
  find skills/ -name SKILL.md | sed -E 's|^skills/([^/]+)/SKILL\.md$|\1|';
  find commands/ -name '*.md' | sed -E 's|^commands/(.+)\.md$|\1|';
)

# Extract every [[name]] from every SKILL.md and command
while IFS= read -r line; do
  if [[ "$line" =~ \[\[([a-z0-9-]+)\]\] ]]; then
    target="${BASH_REMATCH[1]}"
    if ! echo "$KNOWN" | grep -qx "$target"; then
      echo "FAIL: wikilink [[$target]] does not match any skill or command"
      FAIL=1
    fi
  fi
done < <(grep -rh '\[\[[a-z0-9-]\+\]\]' skills/ commands/ 2>/dev/null || true)

if [ "$FAIL" -ne 0 ]; then
  exit 1
fi
echo "OK all wikilinks resolve"
