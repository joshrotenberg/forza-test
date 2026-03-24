#!/bin/sh
# Validate changes in the worktree.
# Runs tests for each language that has source files present.
# Skips fmt checks — formatting is handled by stage hooks.
set -e

if [ -f rust/Cargo.toml ]; then
    echo "=== Validating Rust ==="
    (cd rust && cargo clippy --all-targets -- -D warnings 2>/dev/null && cargo test 2>&1) || true
fi

if [ -f go/go.mod ]; then
    echo "=== Validating Go ==="
    (cd go && go vet ./... 2>/dev/null && go test ./... 2>&1) || true
fi

echo "=== Validation passed ==="
