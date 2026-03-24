#!/bin/sh
# Verify scenario outcomes after a forza run.
# Usage: ./scripts/verify.sh [--all | <issue_number> <expected_outcome>]
#
# Expected outcomes: pr_created, comment_posted, failed
set -e

REPO="joshrotenberg/forza-test"

verify_issue() {
    local number="$1"
    local expected="$2"
    local labels
    labels=$(gh issue view "$number" --repo "$REPO" --json labels --jq '[.labels[].name] | join(",")')

    case "$expected" in
        pr_created)
            if echo "$labels" | grep -q "forza:complete"; then
                echo "PASS  #$number — completed (expected: pr_created)"
            elif echo "$labels" | grep -q "forza:failed"; then
                echo "FAIL  #$number — failed (expected: pr_created)"
                return 1
            else
                echo "WAIT  #$number — still in progress"
                return 1
            fi
            ;;
        comment_posted)
            local comments
            comments=$(gh issue view "$number" --repo "$REPO" --json comments --jq '.comments | length')
            if [ "$comments" -gt 0 ] && echo "$labels" | grep -q "forza:complete"; then
                echo "PASS  #$number — comment posted (expected: comment_posted)"
            else
                echo "FAIL  #$number — no comment or not complete"
                return 1
            fi
            ;;
        failed)
            if echo "$labels" | grep -q "forza:failed"; then
                echo "PASS  #$number — failed as expected"
            else
                echo "FAIL  #$number — did not fail (expected: failed)"
                return 1
            fi
            ;;
        *)
            echo "ERROR unknown expected outcome: $expected"
            return 1
            ;;
    esac
}

if [ "$1" = "--all" ]; then
    echo "=== Verifying all scenarios ==="
    FAILURES=0
    # Rust scenarios
    verify_issue 1 pr_created || FAILURES=$((FAILURES + 1))
    verify_issue 2 pr_created || FAILURES=$((FAILURES + 1))
    verify_issue 3 pr_created || FAILURES=$((FAILURES + 1))
    verify_issue 4 comment_posted || FAILURES=$((FAILURES + 1))
    # Go scenarios
    verify_issue 5 pr_created || FAILURES=$((FAILURES + 1))
    verify_issue 6 pr_created || FAILURES=$((FAILURES + 1))

    echo ""
    if [ "$FAILURES" -gt 0 ]; then
        echo "=== $FAILURES scenario(s) failed ==="
        exit 1
    else
        echo "=== All scenarios passed ==="
    fi
else
    verify_issue "$1" "$2"
fi
