#!/bin/sh
# Create a PR with failing CI for testing auto-fix-ci condition route.
# Usage: ./scripts/scenario-ci-fail.sh
set -e

REPO="joshrotenberg/forza-test"
BRANCH="automation/test-ci-failure"

echo "=== Setting up CI failure scenario ==="

# 1. Create a branch with a broken test
git checkout main
git pull origin main
git checkout -b "$BRANCH"

# Add a test that will fail
cat >> rust/src/lib.rs << 'EOF'

#[cfg(test)]
mod failing_tests {
    use super::calculator::*;

    #[test]
    fn test_broken_addition() {
        // This test intentionally fails — forza should fix it
        assert_eq!(add(2, 2), 5, "2 + 2 should equal 5 (this is wrong)");
    }
}
EOF

git add rust/src/lib.rs
git commit -m "test: add broken test (ci failure scenario)"
git push origin "$BRANCH"

# 2. Create a PR
PR_URL=$(gh pr create --repo "$REPO" --head "$BRANCH" --title "test: broken addition test (ci-fail scenario)" --body "This PR has a failing test. auto-fix-ci should detect and fix it.")
echo "Created PR: $PR_URL"

echo ""
echo "=== CI failure scenario ready ==="
echo "Wait for CI to fail, then run 'forza watch --repo-dir .' or 'forza run --repo-dir .'"
echo "auto-fix-ci should detect ci_failing and run pr-fix-ci workflow."
