# Fleet Commander - Project Governance & Institutional Memory

> **Philosophy**: This file serves as the "system prompt" for all Claude Code instances working on this project. It contains architectural decisions, coding standards, and operational protocols.

## 🎯 Project Overview

**Project Name**: Fleet Commander
**Architecture**: [Describe your stack here]
**Key Technologies**: [List primary technologies]
**Last Updated**: 2026-01-10

---

## 🏗️ Architectural Decisions

### Core Principles
- **Quality over Speed**: Use Opus models for planning to avoid "doom loops"
- **Self-Verification**: Every implementation must pass automated verification
- **Institutional Memory**: All architectural decisions are documented here
- **Governance as Code**: This file is the source of truth for project standards

### Technology Stack
<!-- Update as you build -->
- **Language**: [e.g., TypeScript, Python]
- **Framework**: [e.g., React, FastAPI]
- **Testing**: [e.g., Jest, Pytest]
- **Formatting**: [e.g., Prettier, Black]
- **Linting**: [e.g., ESLint, Ruff]

---

## 📋 Coding Standards

### Code Style
- Use functional programming patterns where appropriate
- Prefer composition over inheritance
- Keep functions small and focused (single responsibility)
- Write self-documenting code; comments explain "why" not "what"

### File Organization
```
/src           - Source code
/tests         - Test files (mirror src structure)
/docs          - Documentation
/.claude       - Claude Code configuration
/scripts       - Utility scripts
```

### Naming Conventions
- **Files**: kebab-case for files (e.g., `user-service.ts`)
- **Functions**: camelCase for functions (e.g., `getUserById`)
- **Classes**: PascalCase for classes (e.g., `UserService`)
- **Constants**: UPPER_SNAKE_CASE for constants (e.g., `MAX_RETRIES`)

### Security Rules
- ❌ Never commit secrets, API keys, or credentials
- ✅ Use environment variables for configuration
- ✅ Validate all user input at boundaries
- ✅ Sanitize data before database operations
- ❌ Never use `eval()` or equivalent unsafe operations

---

## 🔄 Development Workflow

### Planning Phase (Shift+Tab Twice)
1. **Always** enter Plan Mode before implementation
2. Negotiate the plan until it's "airtight"
3. Consider edge cases and failure modes
4. Only switch to Auto-Execute when plan is approved

### Implementation Phase
1. Follow the negotiated plan exactly
2. Write tests alongside implementation
3. Run formatters automatically via hooks
4. Self-verify before marking complete

### Verification Phase
1. All tests must pass
2. Linting must pass
3. Type checking must pass (if applicable)
4. Manual review of critical paths

---

## 🧪 Testing Strategy

### Coverage Requirements
- **Unit Tests**: All business logic functions
- **Integration Tests**: API endpoints and service interactions
- **E2E Tests**: Critical user flows

### Test Patterns
```typescript
// Arrange - Set up test data
// Act - Execute the function
// Assert - Verify the results
```

---

## 🚫 Common Pitfalls to Avoid

### Anti-Patterns
- ❌ Don't over-engineer simple solutions
- ❌ Don't add features that weren't requested
- ❌ Don't refactor unrelated code during bug fixes
- ❌ Don't add unnecessary abstractions
- ❌ Don't ignore test failures

### Known Issues
<!-- Add issues discovered during development -->
- None yet

---

## 🎓 Lessons Learned

### Architectural Lessons
<!-- Append new learnings here via '#' hotkey or PR reviews -->

**Example Entry Format**:
```
[2026-01-10] Database Connection Pooling
- Problem: Connection exhaustion under load
- Solution: Implemented connection pooling with max 20 connections
- Context: See PR #123
- Learning: Always consider connection limits in server design
```

### Code Quality Lessons
<!-- Auto-populated from PR reviews -->

---

## 🔧 Custom Commands & Shortcuts

### Slash Commands
- `/commit-push-pr` - Commit changes, push, and create PR (used dozens of times/day)
- `/implement-feature` - One-shot feature implementation
- `/verify-app` - Run full verification suite

### Hooks
- **PostToolUse**: Auto-format with Prettier/ESLint
- **PreCommit**: Run tests and type checking

---

## 📦 Dependencies & Integrations

### Critical Dependencies
<!-- List mission-critical packages -->

### Integration Points
<!-- Document external services and APIs -->

---

## 🔐 Permissions & Security

### Sandbox Mode
- Default: Permissions required for all operations
- Development: `--permission-mode=dontAsk` (for trusted scripts only)
- Sandbox: `--dangerously-skip-permissions` (sandbox environments only)

### Credential Management
- All secrets in environment variables
- Use `.env.example` as template (committed)
- Never commit `.env` (in .gitignore)

---

## 🚀 Deployment

### Environments
- **Development**: Local development
- **Staging**: Pre-production testing
- **Production**: Live environment

### Deployment Checklist
- [ ] All tests passing
- [ ] No console errors/warnings
- [ ] Environment variables configured
- [ ] Database migrations run
- [ ] Monitoring configured

---

## 📝 Appendix: Quick Reference

### Adding New Learnings
1. **Manual**: Edit this file directly
2. **Hotkey**: Press '#' in CLI to append instantly
3. **PR Review**: Tag @claude in GitHub PR comments

### Fleet Management
- Run 5 concurrent CLI instances (tabs 1-5)
- Use 5-10 web sessions for long-context tasks
- Enable system notifications for completion alerts
- Use `--teleport` to transfer context between CLI and Web

---

**Last Modified**: 2026-01-10
**Next Review**: [Set cadence, e.g., weekly/monthly]
