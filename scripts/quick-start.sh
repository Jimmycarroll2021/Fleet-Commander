#!/bin/bash
#
# Fleet Commander - Quick Start Setup
# Helps users get started with the Fleet Commander workflow
#

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🚀 Fleet Commander - Quick Start"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if jq is installed
if ! command -v jq &> /dev/null; then
  echo -e "${YELLOW}⚠️  jq is not installed. Installing jq for fleet management...${NC}"

  if command -v apt-get &> /dev/null; then
    sudo apt-get update && sudo apt-get install -y jq
  elif command -v brew &> /dev/null; then
    brew install jq
  else
    echo "Please install jq manually: https://stedolan.github.io/jq/download/"
    exit 1
  fi
fi

# Initialize fleet
echo -e "${BLUE}Step 1:${NC} Initializing Fleet Commander..."
./scripts/fleet-manager.sh init
echo ""

# Check CLAUDE.md
echo -e "${BLUE}Step 2:${NC} Checking governance files..."
if [[ -f "CLAUDE.md" ]]; then
  echo -e "${GREEN}✓${NC} CLAUDE.md exists"
else
  echo -e "${YELLOW}⚠️${NC} CLAUDE.md not found"
fi
echo ""

# Check hooks
echo -e "${BLUE}Step 3:${NC} Verifying hooks..."
if [[ -d ".claude/hooks" ]]; then
  echo -e "${GREEN}✓${NC} Hooks directory exists"

  # Make sure hooks are executable
  chmod +x .claude/hooks/*.sh 2>/dev/null || true

  echo -e "${GREEN}✓${NC} Hooks are executable"
else
  echo -e "${YELLOW}⚠️${NC} Hooks directory not found"
fi
echo ""

# Check commands
echo -e "${BLUE}Step 4:${NC} Checking custom commands..."
if [[ -f ".claude/commands.json" ]]; then
  echo -e "${GREEN}✓${NC} Custom commands configured"

  # Validate JSON
  if jq empty .claude/commands.json 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Commands JSON is valid"
  else
    echo -e "${YELLOW}⚠️${NC} Commands JSON has syntax errors"
  fi
else
  echo -e "${YELLOW}⚠️${NC} Custom commands not found"
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  ${GREEN}✓ Fleet Commander is ready!${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Open 5 terminal tabs (⌘T on Mac)"
echo "   - Recommended: iTerm2 or Ghostty"
echo "   - Name tabs 1-5 for easy identification"
echo ""
echo "2. In each tab, run:"
echo "   cd $(pwd)"
echo "   claude-code --model opus-4.5  # for planning"
echo "   # or"
echo "   claude-code --model sonnet-4.5  # for execution"
echo ""
echo "3. Assign tasks using:"
echo "   ./scripts/fleet-manager.sh assign [tab] \"[task]\""
echo ""
echo "4. Check status:"
echo "   ./scripts/fleet-manager.sh status"
echo ""
echo "📚 Documentation:"
echo "   - Full workflow: docs/FLEET_COMMANDER_WORKFLOW.md"
echo "   - Governance: CLAUDE.md"
echo "   - Custom commands: /commit-push-pr, /implement-feature, /verify-app"
echo ""
echo "💡 Tips:"
echo "   - Use Shift+Tab (twice) to enter Plan Mode"
echo "   - Enable system notifications for task completion"
echo "   - Press '#' to quickly add rules to CLAUDE.md"
echo ""
echo "Happy Fleet Commanding! 🚀"
echo ""
