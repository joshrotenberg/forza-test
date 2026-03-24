#!/bin/sh
# Validate changes based on which language directories were modified.
# Runs from the worktree root. Exits non-zero on first failure.
set -e

# Check if Rust files changed
if git diff --cached --name-only 2>/dev/null | grep -q "^rust/" || [ -f rust/Cargo.toml ]; then
    echo "=== Validating Rust ==="
    (cd rust && cargo fmt --all -- --check && cargo clippy --all-targets -- -D warnings && cargo test)
fi

# Check if Go files changed
if git diff --cached --name-only 2>/dev/null | grep -q "^go/" || [ -f go/go.mod ]; then
    echo "=== Validating Go ==="
    (cd go && go fmt ./... && go vet ./... && go test ./...)
fi

echo "=== Validation passed ==="
