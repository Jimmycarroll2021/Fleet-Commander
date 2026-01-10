# The Boris Cherny "Fleet Commander" Workflow

> **Philosophy**: Treat Claude Code as "compute capacity" to be queued and managed, not a chat partner.

**Creator**: Boris Cherny (Creator of Claude Code)
**Source**: YouTube / Blog Posts (Jan 2026)
**Impact**: 2-3x quality improvement via self-verification loops

---

## 🎯 Core Philosophy

Claude Code is **compute capacity** that you orchestrate, not a conversational assistant. Think of yourself as a **Fleet Commander** managing multiple ships (Claude instances) on parallel missions.

### Key Mental Models
1. **Parallel Processing**: Run 5+ instances simultaneously
2. **Task Queueing**: Assign discrete tasks to each instance
3. **Autonomous Loops**: Let Claude self-correct until tasks pass
4. **Governance as Code**: CLAUDE.md is your "system prompt"

---

## 🚀 Quick Start

### 1. Infrastructure Setup (One-Time)

#### Terminal Fleet (5 Concurrent Instances)
```bash
# Recommended Terminal: iTerm2 or Ghostty (for speed)
# Setup:
# - Create 5 tabs (⌘T on Mac)
# - Name them: Tab 1, Tab 2, Tab 3, Tab 4, Tab 5
# - Enable system notifications for background task completion
# - Configure hotkeys for rapid tab switching (⌘1-5)

# In each tab, navigate to your project:
cd /path/to/your/project
claude-code
```

#### Web Fleet (5-10 Background Sessions)
```
1. Open claude.ai/code in Chrome
2. Create 5-10 tabs
3. Use for:
   - Long-context reasoning tasks
   - Visual inspection (UI/debugging)
   - Mobile handoffs (check status on phone)
```

#### Model Selection
```bash
# Use Opus for planning (slower but prevents "doom loops")
claude-code --model opus-4.5

# Use Sonnet for execution (faster)
claude-code --model sonnet-4.5
```

---

## 📋 Daily Operational Workflow

### Morning Routine
```
1. ☕ Check iPhone for overnight agent status
2. 📊 Review Summary outputs from 5 web sessions
3. 📋 Plan today's tasks in CLAUDE.md
4. 🚀 Assign tasks to fleet
```

### Active Hours SOP

#### Step 1: Task Assignment
```
Tab 1: Feature Implementation (e.g., "Add user authentication")
Tab 2: Test Writing (e.g., "Write integration tests for auth")
Tab 3: Documentation (e.g., "Update API docs")
Tab 4: Bug Fixes (e.g., "Fix reported login issue")
Tab 5: Code Review/Refactoring (e.g., "Simplify auth service")
```

#### Step 2: Context Switching Protocol
- **Don't actively monitor** all tabs
- Wait for **system notification** when a task completes
- Switch context only when notified
- Review output, approve or provide feedback
- Queue next task

---

## 🔄 Three-Phase Workflow

### Phase 1: Planning (MANDATORY)

**Hotkey**: `Shift+Tab` (twice) to enter Plan Mode

```
Protocol:
1. Activate Plan Mode
2. Describe the feature/fix in detail
3. Negotiate the plan with Claude
4. Refine until "airtight" (consider edge cases)
5. Only then switch to Auto-Execute
```

**Why Opus for Planning?**
- Prevents "doom loops" (Claude implementing wrong solution)
- Gets architecture right the first time
- Worth the extra 2-3 seconds per request

**Example Planning Session**:
```
You: "I need to add user authentication"

Claude (Plan Mode):
- Proposed Approach:
  1. Create User model with email/password fields
  2. Implement bcrypt for password hashing
  3. Add JWT token generation
  4. Create login/logout endpoints
  5. Add auth middleware

- Edge Cases:
  - Password reset flow
  - Session expiration
  - Rate limiting on login attempts

- Files to Modify:
  - src/models/user.ts (new)
  - src/routes/auth.ts (new)
  - src/middleware/auth.ts (new)
  - src/config/jwt.ts (new)

You: "Approved - proceed"
```

### Phase 2: Execution (One-Shot)

**Strategy**: Let Claude implement entire feature in one go

```bash
# Custom slash commands (use dozens of times/day)
/implement-feature "Add user authentication per the plan"
/commit-push-pr "feat: implement user authentication"
```

**Post-Tool Hooks** (Auto-Formatting):
```json
{
  "hooks": {
    "postToolUse": {
      "command": "prettier --write {file} && eslint --fix {file}",
      "description": "Auto-format after file modifications"
    }
  }
}
```

This fixes the "last 10%" of syntax errors automatically.

### Phase 3: Verification (Self-Correction Loops)

#### The "Ralph Wiggum" Pattern
```
Philosophy: "I'm helping!" loop

1. Claude runs tests
2. If tests fail → Claude analyzes error
3. Claude fixes the issue
4. Repeat until all tests pass
5. Only then mark as complete
```

**Implementation**:
```bash
# Custom verification command
/verify-app

# This triggers:
# 1. Run all tests
# 2. Run linting
# 3. Run type checking
# 4. If any fail, enter autonomous fix loop
# 5. Report when all pass
```

#### Sub-Agent Verification
```bash
# Launch sub-agents for quality audit
claude-code --agent code-simplifier
claude-code --agent security-audit
claude-code --agent performance-check
```

#### Teleport for Visual Debugging
```bash
# Transfer context from CLI to Web for visual inspection
claude-code --teleport

# Use claude.ai/code to:
# - Inspect UI changes
# - Debug visual issues
# - Then teleport back to CLI for fixes
```

---

## 📁 Governance as Code: CLAUDE.md

### Purpose
- **Institutional Memory**: Architectural decisions persist across sessions
- **System Prompt**: Every Claude instance reads this on startup
- **Living Document**: Updated continuously

### Update Mechanisms

#### 1. Manual Editing
```bash
# Edit directly
vim CLAUDE.md

# Add architectural decision
# Document lessons learned
# Update coding standards
```

#### 2. Hotkey Append (Press '#')
```bash
# In Claude Code CLI, press '#' key
# Instantly appends a new rule to CLAUDE.md

Example:
[#] "Never use any in TypeScript - always define proper types"
```

#### 3. PR Review Auto-Extract
```bash
# In GitHub PR comments, tag @claude
# Example PR comment:

@claude extract-learning: "Database connection pooling required for
production - learned after connection exhaustion incident"

# This auto-appends to CLAUDE.md under "Lessons Learned"
```

---

## 🛡️ Permissions as Code

### Configuration
```bash
# Sandbox (disable all permissions prompts)
claude-code --dangerously-skip-permissions

# Trusted Scripts (auto-approve)
claude-code --permission-mode=dontAsk

# Default (ask for each permission)
claude-code
```

### Best Practices
- Use `--dangerously-skip-permissions` **only** in sandbox environments
- Use `--permission-mode=dontAsk` for well-tested automation scripts
- Use default mode when experimenting or working with sensitive data

---

## 🧩 Custom Slash Commands

Create `.claude/commands.json`:

```json
{
  "commands": [
    {
      "name": "commit-push-pr",
      "description": "Commit, push, and create PR (used dozens of times/day)",
      "steps": [
        {
          "action": "git-status",
          "description": "Review changes"
        },
        {
          "action": "git-commit",
          "message": "${prompt}",
          "description": "Commit with descriptive message"
        },
        {
          "action": "git-push",
          "description": "Push to origin"
        },
        {
          "action": "gh-pr-create",
          "description": "Create pull request"
        }
      ]
    },
    {
      "name": "implement-feature",
      "description": "One-shot feature implementation",
      "steps": [
        {
          "action": "plan",
          "description": "Create implementation plan"
        },
        {
          "action": "implement",
          "description": "Execute plan"
        },
        {
          "action": "test",
          "description": "Run verification suite"
        },
        {
          "action": "self-correct",
          "description": "Fix until all tests pass"
        }
      ]
    },
    {
      "name": "verify-app",
      "description": "Run full verification suite",
      "steps": [
        {
          "action": "run-tests",
          "description": "Execute test suite"
        },
        {
          "action": "run-linting",
          "description": "Check code style"
        },
        {
          "action": "run-typecheck",
          "description": "Verify types"
        },
        {
          "action": "build",
          "description": "Attempt production build"
        }
      ]
    }
  ]
}
```

---

## 📊 Metrics & Impact

### Efficiency Gains
- **Quality**: 2-3x improvement via self-verification loops
- **Throughput**: One senior dev = small engineering team output
- **Context Switching**: Reduced by 70% (parallel task execution)
- **Bug Detection**: Earlier (caught in autonomous test loops)

### Team Scaling
```
Traditional: 1 dev → 1 dev worth of output
Fleet Commander: 1 dev → 3-5 devs worth of output

How?
- 5 parallel implementations running simultaneously
- Autonomous verification (no manual QA per task)
- Institutional memory reduces repeated explanations
- Self-correction loops prevent human debugging time
```

---

## 🎓 Advanced Patterns

### Pattern 1: Overnight Batch Processing
```
Before bed:
1. Queue 5 large refactoring tasks (one per web session)
2. Enable notifications
3. Go to sleep

Morning:
1. Check iPhone - see which completed
2. Review outputs in 10 minutes
3. Approve or provide feedback
```

### Pattern 2: Parallel Feature Development
```
Sprint Task: Build entire authentication system

Tab 1: Backend API (auth routes, middleware)
Tab 2: Frontend UI (login/signup forms)
Tab 3: Database migrations (user table, indexes)
Tab 4: Tests (unit + integration)
Tab 5: Documentation (API docs, README)

All complete in 1-2 hours (vs. 1-2 days serial)
```

### Pattern 3: Context Teleportation
```
CLI Session:
"Implement dark mode toggle"
↓
[Implementation complete]
↓
claude-code --teleport
↓
Web Session (Visual):
- Inspect UI in browser
- Identify color contrast issue
↓
Tag in PR comment:
"@claude The dark mode text has poor contrast on buttons"
↓
Teleport back to CLI:
- Auto-receives feedback
- Fixes contrast issue
- Re-verifies
```

---

## 🚨 Troubleshooting

### Claude in a "Doom Loop"
**Symptom**: Repeatedly implementing wrong solution
**Root Cause**: Skipped planning phase or used Sonnet for complex architecture
**Solution**:
1. Stop execution
2. Switch to Opus model
3. Enter Plan Mode (Shift+Tab twice)
4. Re-negotiate plan
5. Then execute with corrected plan

### Tests Failing in Loop
**Symptom**: Claude can't fix failing tests after 3+ attempts
**Root Cause**: Underlying architecture issue
**Solution**:
1. Review CLAUDE.md for architectural constraints
2. Check if test expectations are correct
3. Consider if feature needs re-planning
4. Use `--teleport` to get human eyes on the issue

### Fleet Management Overhead
**Symptom**: Losing track of which tab is doing what
**Solution**:
1. Use terminal tab naming feature
2. Create a task board (simple text file):
   ```
   Tab 1: [IN PROGRESS] Auth API
   Tab 2: [COMPLETED] Tests - Ready for Review
   Tab 3: [QUEUED] Documentation
   Tab 4: [BLOCKED] Bug #123 - waiting for API key
   Tab 5: [IDLE] Available
   ```
3. Update as tasks complete

---

## 📚 Resources

### Boris Cherny's Original Content
- YouTube: [Search "Boris Cherny Claude Code"]
- Blog Posts: [Jan 2026 Publications]

### Community Extensions
- **Ralph Wiggum Plugin**: @GeoffreyHuntley
- **Teleport Feature**: Built into Claude Code
- **Fleet Management Scripts**: This repository

### Related Tools
- **iTerm2**: macOS terminal with tab management
- **Ghostty**: High-performance terminal emulator
- **gh CLI**: GitHub command-line tool
- **jq**: JSON processing for hook scripts

---

## 🤝 Contributing to This Workflow

### Adding New Patterns
1. Test pattern for 1 week minimum
2. Document in "Advanced Patterns" section
3. Add metrics (efficiency gain, time saved)
4. Submit PR with examples

### Improving Documentation
- Keep it actionable (no fluff)
- Add copy-paste examples
- Include failure modes
- Real-world case studies preferred

---

**Last Updated**: 2026-01-10
**Version**: 1.0.0
**Status**: Production-Ready
