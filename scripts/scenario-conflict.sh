#!/bin/sh
# Create a PR with merge conflicts for testing auto-rebase condition route.
# Creates a REAL conflict by modifying the same function on both branches.
# Usage: ./scripts/scenario-conflict.sh
set -e

REPO="joshrotenberg/forza-test"
BRANCH="automation/test-conflict-rebase-v2"

echo "=== Setting up conflict scenario ==="

# 1. Create a branch and MODIFY the existing divide function
git checkout main
git pull origin main
git checkout -b "$BRANCH"

# Change the divide function to return Result instead of Option
sed -i '' 's|pub fn divide(a: i32, b: i32) -> Option<i32> {|pub fn divide(a: i32, b: i32) -> Result<i32, \&str> {|' rust/src/lib.rs
sed -i '' 's|if b == 0 { None } else { Some(a / b) }|if b == 0 { Err("division by zero") } else { Ok(a / b) }|' rust/src/lib.rs

git add rust/src/lib.rs
git commit -m "refactor: change divide to return Result"
git push origin "$BRANCH"

# 2. Create a PR
PR_URL=$(gh pr create --repo "$REPO" --head "$BRANCH" --title "test: change divide return type (conflict scenario)" --body "This PR modifies the divide function. A conflicting change will be pushed to main.")
echo "Created PR: $PR_URL"

# 3. Go back to main and make a DIFFERENT change to the same function
git checkout main

# Add a doc comment and change the function signature differently
sed -i '' 's|pub fn divide(a: i32, b: i32) -> Option<i32> {|/// Divide with checked arithmetic.\npub fn checked_divide(a: i32, b: i32) -> Option<i32> {|' rust/src/lib.rs

git add rust/src/lib.rs
git commit -m "refactor: rename divide to checked_divide"
git push origin main

echo ""
echo "=== Conflict scenario ready ==="
echo "PR modifies divide() one way, main modifies it another way."
echo "Run 'forza run --repo-dir .' — auto-rebase should detect has_conflicts."
