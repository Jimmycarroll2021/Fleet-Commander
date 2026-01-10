#!/bin/bash
#
# On-Session-Start Hook
# Loads CLAUDE.md institutional memory on startup
# Ensures every Claude instance has project context
#

set -e

CLAUDE_MD_PATH="./CLAUDE.md"

if [[ ! -f "$CLAUDE_MD_PATH" ]]; then
  echo "⚠️  CLAUDE.md not found in repository root"
  echo "This file serves as institutional memory for the project."
  echo "Consider creating it for better context across sessions."
  exit 0
fi

echo "📚 Loading institutional memory from CLAUDE.md..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Fleet Commander - Institutional Memory"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Extract and display key sections
echo "📋 Project Overview:"
sed -n '/## 🎯 Project Overview/,/^## /p' "$CLAUDE_MD_PATH" | head -n -1 | tail -n +2

echo ""
echo "🏗️  Recent Architectural Decisions:"
sed -n '/## 🏗️ Architectural Decisions/,/^## /p' "$CLAUDE_MD_PATH" | head -n -1 | tail -n +2 | head -n 10

echo ""
echo "🎓 Recent Lessons Learned:"
sed -n '/## 🎓 Lessons Learned/,/^## /p' "$CLAUDE_MD_PATH" | head -n -1 | tail -n +2 | tail -n 5

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Institutional memory loaded"
echo ""
echo "💡 Tips:"
echo "  - Press '#' to quickly add a new rule to CLAUDE.md"
echo "  - Use /commit-push-pr for rapid iteration"
echo "  - Enter Plan Mode (Shift+Tab twice) before complex tasks"
echo ""

exit 0
