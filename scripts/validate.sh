#!/bin/sh
# Validate changes based on which language directories were modified.
# Only checks languages whose files were actually modified.
# Runs from the worktree root. Exits non-zero on first failure.
set -e

CHANGED=$(git diff HEAD~1 --name-only 2>/dev/null || echo "")

if echo "$CHANGED" | grep -q "^rust/"; then
    echo "=== Validating Rust ==="
    (cd rust && cargo fmt --all -- --check && cargo clippy --all-targets -- -D warnings && cargo test)
fi

if echo "$CHANGED" | grep -q "^go/"; then
    echo "=== Validating Go ==="
    (cd go && go vet ./... && go test ./...)
fi

echo "=== Validation passed ==="
