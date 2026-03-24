#!/bin/sh
# Create test labels and seed scenario issues.
# Run once to set up the test environment.
set -e

REPO="joshrotenberg/forza-test"

echo "=== Creating labels ==="
for label in "test:bug-rust" "test:feature-rust" "test:research-rust" \
             "test:bug-go" "test:feature-go" \
             "forza:ready" "forza:in-progress" "forza:complete" "forza:failed" "forza:needs-human"; do
    gh label create "$label" --repo "$REPO" --force 2>/dev/null || true
    echo "  $label"
done

echo ""
echo "=== Creating Rust scenarios ==="

gh issue create --repo "$REPO" \
    --title "R1: fix compile error in calculator" \
    --body "The \`power\` function in \`rust/src/lib.rs\` has a compile error — it references an undefined variable. Fix it so \`cargo build\` succeeds.

## Acceptance criteria
- \`cargo build\` succeeds
- \`cargo test\` passes
- The \`power\` function correctly computes a^b" \
    --label "test:bug-rust"

gh issue create --repo "$REPO" \
    --title "R2: fix failing test in calculator" \
    --body "The \`test_remainder\` test in \`rust/src/lib.rs\` is failing because the \`remainder\` function returns the wrong value. Fix the implementation.

## Acceptance criteria
- \`cargo test\` passes (all tests including test_remainder)
- The \`remainder\` function correctly computes a % b" \
    --label "test:bug-rust"

gh issue create --repo "$REPO" \
    --title "R3: add modulo function to calculator" \
    --body "Add a \`modulo(a: i32, b: i32) -> Option<i32>\` function to the calculator module in \`rust/src/lib.rs\`. Return \`None\` if b is zero, otherwise return \`Some(a % b)\`. Add tests.

## Acceptance criteria
- \`modulo\` function exists with correct signature
- Returns None for zero divisor
- At least 2 tests covering normal case and zero case
- \`cargo test\` passes" \
    --label "test:feature-rust"

gh issue create --repo "$REPO" \
    --title "R4: research error handling patterns for calculator" \
    --body "Research whether the calculator module should use \`Result<i32, Error>\` instead of \`Option<i32>\` for the divide function. Consider error context, composability, and idiomatic Rust patterns. Post findings as a comment.

## Expected output
A comment with analysis and recommendation." \
    --label "test:research-rust"

echo ""
echo "=== Creating Go scenarios ==="

gh issue create --repo "$REPO" \
    --title "G1: fix nil pointer in calculator" \
    --body "Add a \`Sqrt\` function to \`go/calculator.go\` that computes the integer square root. The function should return an error for negative inputs instead of panicking.

## Acceptance criteria
- \`Sqrt\` function exists
- Returns error for negative input
- \`go test ./...\` passes" \
    --label "test:bug-go"

gh issue create --repo "$REPO" \
    --title "G2: add power function to calculator" \
    --body "Add a \`Power(base, exp int) int\` function to \`go/calculator.go\` that computes base^exp using iterative multiplication. Add tests covering base cases (exp=0, exp=1) and normal cases.

## Acceptance criteria
- \`Power\` function exists
- Power(x, 0) returns 1
- Power(x, 1) returns x
- At least 3 tests
- \`go test ./...\` passes" \
    --label "test:feature-go"

echo ""
echo "=== Done ==="
echo "To run scenarios, label issues with forza:ready:"
echo "  gh issue edit <N> --repo $REPO --add-label forza:ready"
echo ""
echo "Or label all at once:"
echo "  for i in \$(gh issue list --repo $REPO --json number --jq '.[].number'); do"
echo "    gh issue edit \$i --repo $REPO --add-label forza:ready"
echo "  done"

echo ""
echo "=== Creating failure scenarios ==="

gh issue create --repo "$REPO" \
    --title "F1: intentionally vague issue with no acceptance criteria" \
    --body "Make things better. Fix stuff. Improve quality." \
    --label "test:bug-rust"

gh issue create --repo "$REPO" \
    --title "F2: reference nonexistent file" \
    --body "Fix the bug in \`rust/src/networking.rs\` line 42 where the TCP connection leaks.

## Acceptance criteria
- The TCP connection is properly closed
- No resource leaks under load testing

Note: this file does not exist. The agent should plan around this gracefully." \
    --label "test:bug-rust"

echo ""
echo "=== Creating cross-language scenario ==="

gh issue create --repo "$REPO" \
    --title "X1: add absolute value to both Rust and Go calculators" \
    --body "Add an \`abs(n: i32) -> i32\` function (Rust) and \`Abs(n int) int\` function (Go) to both calculator modules. Both should return the absolute value of the input.

## Acceptance criteria
- Rust: \`abs\` function in \`rust/src/lib.rs\` with test
- Go: \`Abs\` function in \`go/calculator.go\` with test
- Both \`cargo test\` and \`go test ./...\` pass" \
    --label "test:feature-rust"

echo ""
echo "=== Creating research verification scenario ==="

gh issue create --repo "$REPO" \
    --title "R5: research testing frameworks for Go calculator" \
    --body "Research Go testing best practices for the calculator module. Specifically:

1. Should we use table-driven tests?
2. Is the standard testing package sufficient or should we use testify?
3. Are there any edge cases in integer arithmetic we should test?

Post findings as a comment with concrete recommendations." \
    --label "test:research-rust"

echo ""
echo "=== Done (Phase 2 scenarios) ==="
