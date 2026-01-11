# Contributing to Fleet Commander

Thank you for your interest in contributing to Fleet Commander! This document provides guidelines and instructions for contributing.

## 🎯 Philosophy

Fleet Commander is a **template and methodology** designed to be customized for your specific project. Contributions should focus on:

1. **Universal Patterns**: Workflows that work across different tech stacks
2. **Developer Experience**: Making the workflow easier to adopt and use
3. **Documentation**: Clear, actionable examples and guides
4. **Community Learnings**: Sharing what works in production

## 🚀 Ways to Contribute

### 1. Share Your Experience

- **Case Studies**: Write about how you use Fleet Commander in your projects
- **Blog Posts**: Share your customizations and optimizations
- **Discussions**: Participate in [GitHub Discussions](https://github.com/yourusername/Fleet-Commander/discussions)
- **Success Metrics**: Share measurable improvements in your workflow

### 2. Improve Documentation

- Fix typos and clarify confusing sections
- Add more examples for different tech stacks
- Create video tutorials or screencasts
- Translate documentation to other languages

### 3. Enhance the Codebase

- Add support for new languages/frameworks in hooks
- Improve the fleet manager CLI with new features
- Create new slash commands for common patterns
- Optimize existing scripts for better performance

### 4. Report Issues

- Bug reports with reproduction steps
- Feature requests with clear use cases
- Documentation gaps or inaccuracies

## 📋 Getting Started

### Prerequisites

Before contributing, ensure you have:

```bash
# 1. Fork the repository on GitHub
# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/Fleet-Commander.git
cd Fleet-Commander

# 3. Add upstream remote
git remote add upstream https://github.com/yourusername/Fleet-Commander.git

# 4. Install dependencies
./scripts/quick-start.sh
```

### Development Setup

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Make your changes
# ...

# Test your changes
./scripts/fleet-manager.sh init
./scripts/fleet-manager.sh status

# Run any custom commands you've modified
claude-code
# Test: /your-custom-command
```

## 🔧 Contribution Guidelines

### Code Style

#### Shell Scripts
```bash
# Use bash shebang
#!/bin/bash

# Enable strict mode
set -e

# Add descriptive comments
# Function: Does something important
do_something() {
  local param=$1
  echo "Processing: $param"
}
```

#### JSON Configuration
```json
{
  "commands": [
    {
      "name": "command-name",
      "description": "Clear, concise description",
      "usage": "/command-name [args]"
    }
  ]
}
```

#### Documentation
- Use clear, actionable language
- Include code examples with comments
- Add "Why this matters" context
- Keep paragraphs short (3-5 sentences)

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
# Format
<type>(<scope>): <description>

# Types
feat:     New feature
fix:      Bug fix
docs:     Documentation changes
style:    Formatting, no code change
refactor: Code refactoring
test:     Adding tests
chore:    Maintenance tasks

# Examples
feat(commands): add /parallel-test command for concurrent test execution
fix(hooks): resolve post-tool-use hook not running on Windows
docs(readme): add troubleshooting section for Docker environments
```

### Pull Request Process

1. **Update Documentation**
   - Update README.md if adding new features
   - Update CHANGELOG.md under `[Unreleased]`
   - Add/update examples in `docs/`

2. **Test Thoroughly**
   ```bash
   # Test hooks
   .claude/hooks/post-tool-use.sh test-file.ts Edit
   .claude/hooks/pre-commit.sh

   # Test fleet manager
   ./scripts/fleet-manager.sh init
   ./scripts/fleet-manager.sh assign 1 "Test task"
   ./scripts/fleet-manager.sh status

   # Test on multiple platforms if possible (Linux, macOS)
   ```

3. **Create Pull Request**
   - Fill out the PR template completely
   - Link related issues
   - Add screenshots/recordings for UI changes
   - Request review from maintainers

4. **Address Review Feedback**
   - Respond to all comments
   - Make requested changes
   - Update tests and docs as needed

## 🎨 Adding New Features

### Adding a New Slash Command

1. Edit `.claude/commands.json`:
```json
{
  "name": "your-command",
  "description": "What this command does",
  "usage": "/your-command [args]",
  "prompt": "Instructions for Claude...",
  "examples": [
    "/your-command \"example usage\""
  ]
}
```

2. Document in README.md:
```markdown
| `/your-command` | Description | Usage pattern |
```

3. Add example in `docs/FLEET_COMMANDER_WORKFLOW.md`

4. Test with real Claude Code session

### Adding Hook Support for a New Language

1. Edit `.claude/hooks/post-tool-use.sh`:
```bash
format_your_language() {
  echo "🎨 Auto-formatting $FILE_PATH..."

  if command -v your-formatter &> /dev/null; then
    your-formatter "$FILE_PATH" 2>/dev/null || true
  fi
}

# Add to case statement
case "$FILE_EXT" in
  yourlang)
    format_your_language
    ;;
```

2. Update `.claude/hooks.json` configuration

3. Document formatter installation in README

### Adding Fleet Manager Features

1. Edit `scripts/fleet-manager.sh`
2. Follow existing pattern for commands
3. Update help text in `show_help()`
4. Add examples in documentation

## 🧪 Testing

### Manual Testing Checklist

- [ ] Quick start script runs without errors
- [ ] Fleet manager commands work correctly
- [ ] Hooks execute at appropriate times
- [ ] Custom commands parse correctly
- [ ] Documentation examples are accurate
- [ ] Works on Linux and macOS
- [ ] Shell scripts have correct permissions

### Testing on Different Platforms

```bash
# Linux
docker run -it ubuntu:latest bash
# Install dependencies and test

# macOS
# Test natively

# Windows (via WSL2)
wsl
# Test in WSL environment
```

## 📝 Documentation Standards

### README Guidelines
- Keep main README concise
- Link to detailed docs for deep dives
- Include visual examples (ASCII art, diagrams)
- Add badges for key metrics

### Code Documentation
```bash
#!/bin/bash
#
# Script Name
# Brief description of what it does
#
# Usage: ./script.sh [args]
#

# Function documentation
# Args:
#   $1 - Description of first arg
# Returns:
#   0 - Success
#   1 - Failure
function_name() {
  # Implementation
}
```

## 🤝 Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the problem, not the person
- Help newcomers learn and contribute
- Give credit where credit is due

### Communication Channels

- **GitHub Issues**: Bug reports, feature requests
- **GitHub Discussions**: Questions, ideas, show-and-tell
- **Pull Requests**: Code contributions
- **Discord/Slack**: Real-time chat (if available)

## 🎓 Learning Resources

### Understanding Fleet Commander
- [Complete Workflow Guide](docs/FLEET_COMMANDER_WORKFLOW.md)
- [Boris Cherny's Original Content](https://youtube.com/@boris-cherny)
- [Claude Code Documentation](https://docs.anthropic.com/claude/docs/claude-code)

### Technical Skills
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [jq Tutorial](https://stedolan.github.io/jq/tutorial/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 🏆 Recognition

Contributors will be recognized in:
- README.md credits section
- CHANGELOG.md for their contributions
- GitHub contributors graph
- Special shoutouts for significant contributions

## 📞 Getting Help

- **Questions**: Open a [Discussion](https://github.com/yourusername/Fleet-Commander/discussions)
- **Bugs**: Create an [Issue](https://github.com/yourusername/Fleet-Commander/issues)
- **Security**: Email security@yourdomain.com (do not open public issue)

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for making Fleet Commander better!** 🚀

Every contribution, no matter how small, helps the community build better software faster.
