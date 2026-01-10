#!/bin/bash
#
# Post-Tool-Use Hook
# Auto-formats code after file modifications
# This fixes the "last 10%" of syntax errors automatically
#

set -e

FILE_PATH="$1"
TOOL_NAME="$2"

# Only run on file write/edit operations
if [[ "$TOOL_NAME" != "Write" && "$TOOL_NAME" != "Edit" ]]; then
  exit 0
fi

# Skip if file doesn't exist
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

# Detect file type and run appropriate formatter
FILE_EXT="${FILE_PATH##*.}"

format_javascript_typescript() {
  echo "🎨 Auto-formatting $FILE_PATH..."

  # Check if prettier is available
  if command -v prettier &> /dev/null; then
    prettier --write "$FILE_PATH" 2>/dev/null || true
  fi

  # Check if eslint is available
  if command -v eslint &> /dev/null; then
    eslint --fix "$FILE_PATH" 2>/dev/null || true
  fi
}

format_python() {
  echo "🎨 Auto-formatting $FILE_PATH..."

  # Check if black is available
  if command -v black &> /dev/null; then
    black "$FILE_PATH" 2>/dev/null || true
  fi

  # Check if ruff is available
  if command -v ruff &> /dev/null; then
    ruff check --fix "$FILE_PATH" 2>/dev/null || true
  fi
}

format_rust() {
  echo "🎨 Auto-formatting $FILE_PATH..."

  if command -v rustfmt &> /dev/null; then
    rustfmt "$FILE_PATH" 2>/dev/null || true
  fi
}

format_go() {
  echo "🎨 Auto-formatting $FILE_PATH..."

  if command -v gofmt &> /dev/null; then
    gofmt -w "$FILE_PATH" 2>/dev/null || true
  fi
}

# Route to appropriate formatter
case "$FILE_EXT" in
  js|jsx|ts|tsx|mjs|cjs)
    format_javascript_typescript
    ;;
  py)
    format_python
    ;;
  rs)
    format_rust
    ;;
  go)
    format_go
    ;;
  *)
    # Unknown file type, skip formatting
    exit 0
    ;;
esac

echo "✅ Auto-formatting complete"
exit 0
