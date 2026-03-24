#!/bin/sh
# Create a clean PR for testing auto-merge condition route.
# Usage: ./scripts/scenario-green-pr.sh
set -e

REPO="joshrotenberg/forza-test"
BRANCH="automation/test-auto-merge"

echo "=== Setting up green PR scenario ==="

# 1. Create a branch with a clean change
git checkout main
git pull origin main
git checkout -b "$BRANCH"

# Add a passing test
cat >> rust/src/lib.rs << 'EOF'

#[cfg(test)]
mod auto_merge_tests {
    use super::calculator::*;

    #[test]
    fn test_add_negative() {
        assert_eq!(add(-1, -2), -3);
    }

    #[test]
    fn test_multiply_by_zero() {
        assert_eq!(multiply(42, 0), 0);
    }
}
EOF

git add rust/src/lib.rs
git commit -m "test: add edge case tests for calculator"
git push origin "$BRANCH"

# 2. Create a PR
PR_URL=$(gh pr create --repo "$REPO" --head "$BRANCH" --title "test: edge case tests (auto-merge scenario)" --body "This PR should pass CI and be auto-merged by forza.")
echo "Created PR: $PR_URL"

echo ""
echo "=== Green PR scenario ready ==="
echo "Wait for CI to pass, then run 'forza watch --repo-dir .' or 'forza run --repo-dir .'"
echo "auto-merge should detect ci_green_no_objections and merge the PR."
