#!/bin/sh
# Create a PR with merge conflicts for testing auto-rebase condition route.
# Usage: ./scripts/scenario-conflict.sh
set -e

REPO="joshrotenberg/forza-test"
BRANCH="automation/test-conflict-rebase"

echo "=== Setting up conflict scenario ==="

# 1. Create a branch from current main and add a function
git checkout main
git pull origin main
git checkout -b "$BRANCH"

# Add a function at the end of the Rust calculator
cat >> rust/src/lib.rs << 'EOF'

/// Square a number (added on branch).
pub fn square(n: i32) -> i32 {
    n * n
}
EOF

git add rust/src/lib.rs
git commit -m "feat: add square function"
git push origin "$BRANCH"

# 2. Create a PR
PR_URL=$(gh pr create --repo "$REPO" --head "$BRANCH" --title "test: add square function (conflict scenario)" --body "This PR will have conflicts after main is updated." --label "forza:ready")
echo "Created PR: $PR_URL"

# 3. Go back to main and push a conflicting change
git checkout main

# Add a different function at the same location
cat >> rust/src/lib.rs << 'EOF'

/// Cube a number (added on main).
pub fn cube(n: i32) -> i32 {
    n * n * n
}
EOF

git add rust/src/lib.rs
git commit -m "feat: add cube function (creates conflict)"
git push origin main

echo ""
echo "=== Conflict scenario ready ==="
echo "PR has conflicts. Run 'forza watch --repo-dir .' or 'forza run --repo-dir .'"
echo "auto-rebase should detect has_conflicts and run pr-rebase workflow."
