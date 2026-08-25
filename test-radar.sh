#!/usr/bin/env bash

set -euo pipefail

# Self-test script to ensure the radar works as expected

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

cd "$TMP_DIR"
git init -b main >/dev/null 2>&1
git config user.name "Test User"
git config user.email "test@example.com"

# Create some dummy files and commit them multiple times
echo "v1" > fileA.txt
git add fileA.txt && git commit -m "add fileA" >/dev/null 2>&1

echo "v1" > fileB.txt
git add fileB.txt && git commit -m "add fileB" >/dev/null 2>&1

echo "v2" > fileA.txt
git add fileA.txt && git commit -m "update fileA" >/dev/null 2>&1

echo "v3" > fileA.txt
git add fileA.txt && git commit -m "update fileA again" >/dev/null 2>&1

# Run the radar script against this temp repo
SCRIPT_PATH="$OLDPWD/hotspot-radar.sh"

OUTPUT=$("$SCRIPT_PATH" 2)

if echo "$OUTPUT" | grep -q "fileA.txt"; then
    echo "Test passed: fileA.txt correctly identified as hotspot."
else
    echo "Test failed: Expected fileA.txt to be listed." >&2
    exit 1
fi
