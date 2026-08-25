#!/usr/bin/env bash

set -euo pipefail

# git-hotspot-radar: Find your most volatile files
# Written because guessing technical debt is a fool's errand.

TOP_N=${1:-10}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository. Run this from the root of a project." >&2
    exit 1
fi

echo "==> Analyzing git commit history for volatility hotspots..."
echo "==> Showing top ${TOP_N} most frequently modified files"
echo "--------------------------------------------------"

# Extract all paths from history, clean blank lines, sort, count frequencies, and sort numerically descending
git log --name-only --format="" \
    | sed '/^$/d' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -n "${TOP_N}" \
    | awk '{printf "  [Changes: %5s]  %s\n", $1, $2}'

echo "--------------------------------------------------"
echo "==> Radar sweep complete. Refactor accordingly."
