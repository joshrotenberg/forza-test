# forza-test

Integration test scenarios for [forza](https://github.com/joshrotenberg/forza).

## Setup

```bash
./scripts/setup.sh          # Create labels and seed issues
```

## Run

```bash
# Label specific scenarios as ready
gh issue edit 1 --repo joshrotenberg/forza-test --add-label forza:ready

# Run forza
forza run --repo-dir .

# Or watch mode
forza watch --repo-dir .
```

## Verify

```bash
./scripts/verify.sh --all           # Check all scenarios
./scripts/verify.sh 1 pr_created    # Check one scenario
```

## Scenarios

### Rust
| # | Scenario | Label | Expected |
|---|----------|-------|----------|
| R1 | Fix compile error | `test:bug-rust` | PR created |
| R2 | Fix failing test | `test:bug-rust` | PR created |
| R3 | Add modulo function | `test:feature-rust` | PR created |
| R4 | Research error handling | `test:research-rust` | Comment posted |

### Go
| # | Scenario | Label | Expected |
|---|----------|-------|----------|
| G1 | Add sqrt with error handling | `test:bug-go` | PR created |
| G2 | Add power function | `test:feature-go` | PR created |
