<div align="center">

# ⚡ Fleet Commander Workflow

### Transform Claude Code into a Parallel Processing Powerhouse

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/yourusername/Fleet-Commander/releases)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Ready-purple.svg)](https://claude.ai/code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**A complete implementation of Boris Cherny's "Fleet Commander" workflow for managing multiple Claude Code instances as orchestrated compute capacity.**

[Quick Start](#-quick-start) •
[Documentation](docs/FLEET_COMMANDER_WORKFLOW.md) •
[Commands](#-custom-slash-commands) •
[Contributing](CONTRIBUTING.md) •
[Changelog](CHANGELOG.md)

</div>

---

## 🎯 What is Fleet Commander?

Fleet Commander is a methodology for treating Claude Code as **compute capacity** rather than a conversational assistant. Instead of having one Claude session, you run 5+ instances in parallel, each working on independent tasks while you orchestrate them like a fleet commander managing multiple ships.

```
┌─────────────────────────────────────────────────────────────┐
│                    YOU (Fleet Commander)                     │
│              Orchestrating Multiple Claude Instances         │
└──────────┬──────────┬──────────┬──────────┬─────────────────┘
           │          │          │          │
    ┌──────▼──────┐ ┌▼──────────┐ ┌▼──────────┐ ┌▼──────────┐ ┌▼──────────┐
    │   Tab 1     │ │   Tab 2   │ │   Tab 3   │ │   Tab 4   │ │   Tab 5   │
    │   Feature   │ │   Tests   │ │   Docs    │ │  Bug Fix  │ │  Review   │
    │Implementation│ │  Writing  │ │  Update   │ │   #123    │ │  Code     │
    └─────────────┘ └───────────┘ └───────────┘ └───────────┘ └───────────┘
           │                │              │             │             │
           ▼                ▼              ▼             ▼             ▼
    [Autonomous]     [Autonomous]    [Autonomous]  [Autonomous]  [Autonomous]
    [Self-Verify]    [Self-Verify]   [Self-Verify] [Self-Verify] [Self-Verify]
           │                │              │             │             │
           ▼                ▼              ▼             ▼             ▼
    [Notification]   [Notification]  [Notification][Notification][Notification]
     "Task Done!"     "Tests Pass!"   "Docs Ready"  "Bug Fixed"  "Review OK"
```

### Key Benefits

- **⚡ 2-3x quality improvement** via self-verification loops
- **🚀 One senior dev = small team output** through parallel execution
- **🧠 Institutional memory** that persists across sessions
- **🛡️ Autonomous verification** that catches bugs before you see them
- **📊 Reduced context switching** by 70% - work only when notified
- **🔄 Self-healing code** through autonomous correction loops

## 🚀 Quick Start

### Prerequisites

- **Claude Code CLI** installed ([Installation Guide](https://docs.anthropic.com/claude/docs/claude-code))
- **Git** for version control
- **jq** for JSON processing (auto-installed by quick-start script)
- Terminal with tab support (iTerm2, Ghostty, or similar recommended)

### Installation

```bash
# 1. Clone this repository (or use as template on GitHub)
git clone https://github.com/yourusername/Fleet-Commander.git
cd Fleet-Commander

# 2. Run the automated setup (installs dependencies, initializes fleet)
chmod +x scripts/quick-start.sh
./scripts/quick-start.sh

# 3. Customize CLAUDE.md for your specific project
vim CLAUDE.md
# Add your tech stack, architectural decisions, and team standards

# 4. (Optional) Test a custom command
claude-code
# Then type: /verify-app
```

### Video Tutorial

> 📹 **Coming Soon**: Step-by-step video walkthrough of Fleet Commander setup

### Basic Usage

```bash
# Terminal Fleet (5 instances)
# Open 5 tabs and run in each:
claude-code --model opus-4.5    # For planning
claude-code --model sonnet-4.5  # For execution

# Assign tasks
./scripts/fleet-manager.sh assign 1 "Implement user authentication"
./scripts/fleet-manager.sh assign 2 "Write integration tests"
./scripts/fleet-manager.sh assign 3 "Update API documentation"

# Check status
./scripts/fleet-manager.sh status

# View activity log
./scripts/fleet-manager.sh log
```

## 📁 Project Structure

```
Fleet-Commander/
├── CLAUDE.md                          # 🎯 Institutional memory (edit frequently!)
├── README.md                          # This file
├── .claude/
│   ├── hooks.json                     # Hook configuration
│   ├── commands.json                  # Custom slash commands
│   └── hooks/
│       ├── post-tool-use.sh          # Auto-formatting
│       ├── pre-commit.sh             # Pre-commit verification
│       ├── on-session-start.sh       # Load CLAUDE.md
│       └── on-task-complete.sh       # Notifications
├── docs/
│   └── FLEET_COMMANDER_WORKFLOW.md   # 📚 Complete workflow guide
└── scripts/
    ├── fleet-manager.sh              # Fleet management CLI
    └── quick-start.sh                # Setup script
```

## 🔄 The Three-Phase Workflow

### Phase 1: Planning (MANDATORY)

**Hotkey**: `Shift+Tab` (twice) to enter Plan Mode

```
1. Activate Plan Mode
2. Describe the feature/fix
3. Negotiate until plan is "airtight"
4. Only then switch to Auto-Execute
```

**Why this matters**: Using Opus for planning prevents "doom loops" where Claude implements the wrong solution and has to redo work.

### Phase 2: Execution (One-Shot)

```bash
# Use custom slash commands
/implement-feature "Add user authentication per the plan"
/commit-push-pr "feat: implement user authentication"
```

**Auto-formatting**: Post-tool hooks automatically run Prettier, ESLint, Black, etc. after file modifications.

### Phase 3: Verification (Self-Correction)

```bash
# Autonomous verification loop
/verify-app

# Claude will:
# 1. Run tests
# 2. If failures → analyze → fix → re-run
# 3. Repeat until all pass
# 4. Run linting, type checking, build
# 5. Report when everything passes
```

## 🛡️ Governance as Code: CLAUDE.md

The `CLAUDE.md` file is your **system prompt** - every Claude instance reads it on startup.

### What Goes in CLAUDE.md?

- **Architectural decisions**: "Use JWT for authentication"
- **Coding standards**: "Always use functional patterns"
- **Lessons learned**: "Connection pooling required for production"
- **Security rules**: "Never commit API keys"
- **Testing strategy**: "Unit tests for all business logic"

### Updating CLAUDE.md

```bash
# Method 1: Edit directly
vim CLAUDE.md

# Method 2: Press '#' in Claude Code CLI
# Instantly appends a new rule

# Method 3: PR Review (if configured)
# Tag @claude in GitHub PR comments
# Example: "@claude extract-learning: Always validate email format"
```

## 🔧 Custom Slash Commands

This workflow includes 10+ custom commands:

| Command | Description | Usage |
|---------|-------------|-------|
| `/commit-push-pr` | Commit, push, create PR | Used dozens of times/day |
| `/implement-feature` | One-shot feature implementation | Full workflow with planning |
| `/verify-app` | Run full verification suite | Tests, lint, type check, build |
| `/add-learning` | Add lesson to CLAUDE.md | Quick documentation |
| `/plan-sprint` | Break sprint into parallel tasks | Fleet task assignment |
| `/self-correct` | Autonomous fix loop | Keep running until tests pass |
| `/review-code` | Security & quality review | Comprehensive code review |
| `/generate-tests` | Generate test suite | Full test coverage |
| `/quick-fix` | Minimal bug fix | Fast iteration |

See `.claude/commands.json` for full list and customization.

## 🪝 Hooks

Hooks automate repetitive tasks:

### Post-Tool-Use Hook
- **Trigger**: After file write/edit
- **Action**: Auto-format with Prettier/ESLint/Black/etc.
- **Benefit**: Fixes "last 10%" of syntax errors

### Pre-Commit Hook
- **Trigger**: Before git commit
- **Action**: Run tests, linting, type checking
- **Benefit**: Prevents broken code from being committed

### On-Session-Start Hook
- **Trigger**: Claude Code startup
- **Action**: Display CLAUDE.md summary
- **Benefit**: Instant context loading

### On-Task-Complete Hook
- **Trigger**: Task finishes in background
- **Action**: System notification
- **Benefit**: Switch context only when notified

## 🎓 Advanced Patterns

### Pattern 1: Overnight Batch Processing

```bash
# Before bed
./scripts/fleet-manager.sh assign 1 "Refactor auth module"
./scripts/fleet-manager.sh assign 2 "Optimize database queries"
./scripts/fleet-manager.sh assign 3 "Update documentation"

# Morning
./scripts/fleet-manager.sh summary
# Review completed work in 10 minutes
```

### Pattern 2: Parallel Feature Development

```
Sprint: Build authentication system

Tab 1: Backend API (routes, middleware)
Tab 2: Frontend UI (login/signup forms)
Tab 3: Database migrations (user table)
Tab 4: Tests (unit + integration)
Tab 5: Documentation (API docs)

Result: 1-2 hours instead of 1-2 days
```

### Pattern 3: Context Teleportation

```bash
# CLI: Implement feature
claude-code

# Teleport to Web for visual inspection
claude-code --teleport

# Web: Inspect UI, identify issues
# Tag in PR: "@claude fix dark mode contrast"

# Teleport back to CLI
# Claude auto-receives feedback and fixes
```

## 📊 Metrics & Impact

### Efficiency Gains
- **Quality**: 2-3x improvement
- **Throughput**: 3-5x more output per developer
- **Context Switching**: 70% reduction
- **Bug Detection**: Earlier (caught in autonomous loops)

### Team Scaling
- **Traditional**: 1 dev → 1 dev output
- **Fleet Commander**: 1 dev → 3-5 devs output

## 🚨 Troubleshooting

### Claude in a "Doom Loop"
**Symptom**: Repeatedly implementing wrong solution

**Solution**:
1. Stop execution
2. Switch to Opus model
3. Enter Plan Mode (Shift+Tab twice)
4. Re-negotiate plan with more detail

### Tests Failing in Loop
**Symptom**: Can't fix after 3+ attempts

**Solution**:
1. Check CLAUDE.md architectural constraints
2. Verify test expectations are correct
3. Use `--teleport` for human review

### Fleet Management Overhead
**Symptom**: Losing track of tabs

**Solution**: Use terminal tab naming + `./scripts/fleet-manager.sh status`

## 📚 Documentation

- **[Complete Workflow Guide](docs/FLEET_COMMANDER_WORKFLOW.md)** - In-depth methodology
- **[CLAUDE.md](CLAUDE.md)** - Institutional memory template
- **[Hooks Configuration](.claude/hooks.json)** - Hook setup
- **[Custom Commands](.claude/commands.json)** - Command reference

## 🤝 Contributing

This is a template for YOUR project. Customize it:

1. **CLAUDE.md**: Add your architectural decisions
2. **Hooks**: Adjust for your tech stack
3. **Commands**: Create project-specific commands
4. **Scripts**: Extend fleet manager for your needs

### Sharing Improvements

If you create useful patterns or tools, consider:
- Sharing in discussions
- Creating blog posts
- Contributing back to the community

## 🎬 Getting Started Checklist

- [ ] Run `./scripts/quick-start.sh`
- [ ] Customize `CLAUDE.md` for your project
- [ ] Configure hooks for your tech stack
- [ ] Test custom slash commands
- [ ] Open 5 terminal tabs
- [ ] Assign your first parallel tasks
- [ ] Enable system notifications
- [ ] Add your first lesson to CLAUDE.md

## 💡 Tips from Boris Cherny

1. **Always plan first** - Use Opus for planning to avoid doom loops
2. **Trust autonomous loops** - Let Claude self-correct until tests pass
3. **Update CLAUDE.md frequently** - It's your competitive advantage
4. **Enable notifications** - Context switch only when necessary
5. **Use web sessions for long-context** - Visual debugging and mobile handoff

## 📄 License

MIT - Use this template however you want!

## 🙏 Credits

- **Workflow Creator**: Boris Cherny (Creator of Claude Code)
- **Source**: YouTube / Blog Posts (Jan 2026)
- **Community Contributions**:
  - Ralph Wiggum Plugin: @GeoffreyHuntley
  - Various optimization patterns from the community

---

**Last Updated**: 2026-01-10
**Version**: 1.0.0
**Status**: Production-Ready

🚀 **Ready to command your fleet? Run `./scripts/quick-start.sh` to begin!**
