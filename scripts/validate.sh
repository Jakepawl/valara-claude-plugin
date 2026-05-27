#!/usr/bin/env bash
set -euo pipefail

# Plugin validation script - runs locally + in CI.
# Each check exits non-zero on failure with a clear FAIL line.
#
# /usr/bin/env shebang so macOS users with Homebrew bash get bash 5
# instead of /bin/bash 3.2.x (which doesn't support reliable
# BASH_REMATCH in the called validate-wikilinks.sh).

if [ "${BASH_VERSINFO[0]:-0}" -lt 4 ]; then
  echo "FAIL: validate.sh requires bash 4 or newer." >&2
  exit 1
fi

cd "$(dirname "$0")/.."

FAIL=0

echo "=== 1. JSON manifests parse ==="
python3 -c "import json; json.load(open('.claude-plugin/plugin.json'))" && echo "OK plugin.json" || FAIL=1
python3 -c "import json; json.load(open('.claude-plugin/marketplace.json'))" && echo "OK marketplace.json" || FAIL=1
python3 -c "import json; json.load(open('.mcp.json'))" && echo "OK .mcp.json" || FAIL=1

echo ""
echo "=== 2. plugin.json manifest fields ==="
python3 - <<'PY'
import json
m = json.load(open('.claude-plugin/plugin.json'))
required = {"name", "version", "description", "author"}
missing = required - set(m.keys())
if missing:
    print(f"FAIL: plugin.json missing required fields: {missing}")
    exit(1)
if m["name"] != "valara":
    print(f"FAIL: plugin.json name must be 'valara', got {m['name']!r}")
    exit(1)
print("OK manifest fields")
PY

echo ""
echo "=== 3. SKILL.md line-limit (max 80 per Contract 10) ==="
while IFS= read -r f; do
  lines=$(wc -l < "$f")
  if [ "$lines" -gt 80 ]; then
    echo "FAIL: $f is $lines lines (max 80)"
    FAIL=1
  fi
done < <(find skills/ -name SKILL.md)
[ "$FAIL" -eq 0 ] && echo "OK all SKILL.md under 80 lines"

echo ""
echo "=== 4. Forbidden phrases (Contract 11) ==="
# Word-boundary anchors (\b...\b) prevent legitimate JSON field name
# "anti_patterns" (underscore-separated, used in SKILL.md prose to
# reference the AssistantHint schema) from tripping the gate against
# the hyphen-separated forbidden phrase "anti-pattern".
if grep -rIE '\banti-pattern\b|\bbrand voice\b|\bnever auto-publish\b|\btone_hint\b|\bpunchier\b|\bsalesy\b' skills/ 2>/dev/null; then
  echo "FAIL: found IP-protected phrase in public skills - move to server-side"
  FAIL=1
else
  echo "OK no forbidden phrases"
fi

echo ""
echo "=== 5. Em dash check (CLAUDE.md Rule 41) ==="
# Cycle 3 finding M5: use the raw UTF-8 byte sequence for U+2014
# instead of GNU-grep -P Perl regex. BSD grep on macOS does not
# support -P, so the previous `grep -rIP '\x{2014}'` aborts locally
# with `grep: -P is not supported` (the CI runs Ubuntu/GNU grep, which
# masks the issue). LC_ALL=C plus the explicit 3-byte UTF-8 encoding
# works identically on GNU grep + BSD grep.
if LC_ALL=C grep -rI $'\xe2\x80\x94' skills/ commands/ 2>/dev/null; then
  echo "FAIL: em dash (U+2014) found - use hyphen-minus per Rule 41"
  FAIL=1
else
  echo "OK no em dashes"
fi

echo ""
echo "=== 6. Wikilink integrity ==="
bash scripts/validate-wikilinks.sh

echo ""
if [ "$FAIL" -ne 0 ]; then
  echo "=== VALIDATION FAILED ==="
  exit 1
fi
echo "=== VALIDATION PASSED ==="
