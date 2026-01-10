#!/bin/bash
#
# Pre-Commit Hook
# Runs tests, linting, and type checking before commits
# Prevents broken code from being committed
#

set -e

echo "🔍 Running pre-commit verification..."

# Track if any checks fail
CHECKS_FAILED=0

# Function to run a check and track result
run_check() {
  local check_name="$1"
  local check_command="$2"

  echo ""
  echo "▶️  $check_name"

  if eval "$check_command"; then
    echo "✅ $check_name passed"
  else
    echo "❌ $check_name failed"
    CHECKS_FAILED=1
  fi
}

# Detect project type and run appropriate checks
detect_and_verify() {
  # JavaScript/TypeScript Project
  if [[ -f "package.json" ]]; then
    echo "📦 Detected Node.js project"

    # Run tests
    if grep -q '"test"' package.json; then
      run_check "Tests" "npm test"
    fi

    # Run linting
    if command -v eslint &> /dev/null; then
      run_check "ESLint" "eslint ."
    fi

    # Run type checking (TypeScript)
    if [[ -f "tsconfig.json" ]] && grep -q '"typescript"' package.json; then
      run_check "Type Checking" "npx tsc --noEmit"
    fi

    # Run prettier check
    if command -v prettier &> /dev/null; then
      run_check "Prettier" "prettier --check ."
    fi

    # Try to build
    if grep -q '"build"' package.json; then
      run_check "Build" "npm run build"
    fi
  fi

  # Python Project
  if [[ -f "pyproject.toml" || -f "setup.py" || -f "requirements.txt" ]]; then
    echo "🐍 Detected Python project"

    # Run tests with pytest
    if command -v pytest &> /dev/null; then
      run_check "Tests" "pytest"
    fi

    # Run type checking with mypy
    if command -v mypy &> /dev/null; then
      run_check "Type Checking" "mypy ."
    fi

    # Run linting with ruff
    if command -v ruff &> /dev/null; then
      run_check "Ruff" "ruff check ."
    fi

    # Run formatting check with black
    if command -v black &> /dev/null; then
      run_check "Black" "black --check ."
    fi
  fi

  # Rust Project
  if [[ -f "Cargo.toml" ]]; then
    echo "🦀 Detected Rust project"

    # Run tests
    run_check "Tests" "cargo test"

    # Run clippy
    run_check "Clippy" "cargo clippy -- -D warnings"

    # Check formatting
    run_check "Format Check" "cargo fmt -- --check"

    # Try to build
    run_check "Build" "cargo build"
  fi

  # Go Project
  if [[ -f "go.mod" ]]; then
    echo "🐹 Detected Go project"

    # Run tests
    run_check "Tests" "go test ./..."

    # Run go vet
    run_check "Go Vet" "go vet ./..."

    # Check formatting
    run_check "Go Fmt" "test -z \$(gofmt -l .)"

    # Try to build
    run_check "Build" "go build ./..."
  fi
}

# Run detection and verification
detect_and_verify

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Report results
if [[ $CHECKS_FAILED -eq 0 ]]; then
  echo "✅ All pre-commit checks passed!"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 0
else
  echo "❌ Some pre-commit checks failed"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "Fix the errors above before committing."
  echo "Or use 'git commit --no-verify' to skip checks (not recommended)."
  exit 1
fi
