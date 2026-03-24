#!/bin/sh
# Create two competing issues that modify the same file.
# Tests: parallel processing → conflict → auto-rebase → merge.
# Usage: ./scripts/scenario-concurrent.sh
set -e

REPO="joshrotenberg/forza-test"

echo "=== Setting up concurrent modification scenario ==="

# Create two issues targeting the same file
ISSUE1=$(gh issue create --repo "$REPO" \
    --title "C1: add is_even function to Rust calculator" \
    --body "Add \`is_even(n: i32) -> bool\` to the calculator module in \`rust/src/lib.rs\`. Returns true if n is divisible by 2. Add a test.

## Acceptance criteria
- \`is_even\` function exists
- Returns true for even numbers, false for odd
- Test covers both cases" \
    --label "test:feature-rust" --label "forza:ready" 2>&1 | tail -1)

ISSUE2=$(gh issue create --repo "$REPO" \
    --title "C2: add is_positive function to Rust calculator" \
    --body "Add \`is_positive(n: i32) -> bool\` to the calculator module in \`rust/src/lib.rs\`. Returns true if n > 0. Add a test.

## Acceptance criteria
- \`is_positive\` function exists
- Returns true for positive numbers, false for zero and negative
- Test covers positive, zero, and negative cases" \
    --label "test:feature-rust" --label "forza:ready" 2>&1 | tail -1)

echo "Created: $ISSUE1"
echo "Created: $ISSUE2"
echo ""
echo "=== Concurrent scenario ready ==="
echo "Both issues are labeled forza:ready."
echo "Run 'forza run --repo-dir .' — both should process in parallel."
echo "First to merge wins; second gets conflict; auto-rebase resolves it."
