# Fleet Commander Examples

This directory contains example configurations for different tech stacks and use cases.

## 📁 Available Examples

### Language-Specific Configurations

- **[javascript-typescript/](javascript-typescript/)** - Node.js projects with Prettier, ESLint, TypeScript
- **[python/](python/)** - Python projects with Black, Ruff, pytest, mypy
- **[rust/](rust/)** - Rust projects with rustfmt, clippy, cargo

### Usage

Each example contains:
- `.claude-example/hooks.json` - Hook configuration for that tech stack
- Sample CLAUDE.md template (coming soon)
- Custom commands specific to the stack (coming soon)

## 🚀 How to Use These Examples

### 1. Copy Configuration to Your Project

```bash
# Example: Setting up for a TypeScript project
cd your-typescript-project

# Copy the example configuration
cp -r /path/to/Fleet-Commander/examples/javascript-typescript/.claude-example .claude

# Make hooks executable
chmod +x .claude/hooks/*.sh

# Initialize fleet management
/path/to/Fleet-Commander/scripts/fleet-manager.sh init
```

### 2. Customize for Your Project

```bash
# Edit hooks configuration
vim .claude/hooks.json

# Customize institutional memory
vim CLAUDE.md

# Test your configuration
claude-code
# Try: /verify-app
```

### 3. Install Required Tools

#### JavaScript/TypeScript
```bash
npm install --save-dev prettier eslint typescript
# or
yarn add -D prettier eslint typescript
```

#### Python
```bash
pip install black ruff pytest mypy
# or
poetry add --group dev black ruff pytest mypy
```

#### Rust
```bash
# Tools come with Rust toolchain
rustup component add rustfmt clippy
```

## 🔧 Customization Tips

### Modifying Hooks

Edit `.claude/hooks/post-tool-use.sh` to customize formatting behavior:

```bash
# Add your custom formatter
format_your_language() {
  echo "🎨 Auto-formatting $FILE_PATH..."
  your-formatter "$FILE_PATH"
}

# Add to case statement
case "$FILE_EXT" in
  yourlang)
    format_your_language
    ;;
```

### Adding Project-Specific Commands

Edit `.claude/commands.json`:

```json
{
  "commands": [
    {
      "name": "deploy-staging",
      "description": "Deploy to staging environment",
      "usage": "/deploy-staging",
      "prompt": "Your deployment instructions here"
    }
  ]
}
```

## 📚 Stack-Specific Best Practices

### JavaScript/TypeScript

**Recommended Tools**:
- Prettier (formatting)
- ESLint (linting)
- TypeScript (type checking)
- Jest or Vitest (testing)

**CLAUDE.md Tips**:
```markdown
### Technology Stack
- Language: TypeScript 5.x
- Framework: React 18 / Next.js 14
- Testing: Jest + React Testing Library
- Linting: ESLint with airbnb config
- Formatting: Prettier
```

### Python

**Recommended Tools**:
- Black (formatting)
- Ruff (fast linting)
- pytest (testing)
- mypy (type checking)

**CLAUDE.md Tips**:
```markdown
### Technology Stack
- Language: Python 3.11+
- Framework: FastAPI / Django
- Testing: pytest with coverage
- Linting: Ruff (replaces flake8, isort)
- Formatting: Black
- Type Checking: mypy in strict mode
```

### Rust

**Recommended Tools**:
- rustfmt (formatting)
- clippy (linting)
- cargo test (testing)
- cargo doc (documentation)

**CLAUDE.md Tips**:
```markdown
### Technology Stack
- Language: Rust 1.75+
- Testing: Built-in test framework
- Linting: Clippy with -D warnings
- Formatting: rustfmt
- Build: cargo with release profile
```

## 🎯 Common Patterns

### Monorepo Configuration

For monorepos, create separate `.claude` directories in each package:

```
monorepo/
├── packages/
│   ├── frontend/
│   │   └── .claude/
│   ├── backend/
│   │   └── .claude/
│   └── shared/
│       └── .claude/
└── CLAUDE.md (root-level institutional memory)
```

### Multi-Language Projects

Combine configurations in a single `.claude/hooks.json`:

```json
{
  "configuration": {
    "autoFormat": {
      "typescript": ["prettier --write", "eslint --fix"],
      "python": ["black", "ruff check --fix"],
      "rust": ["rustfmt"]
    }
  }
}
```

## 🤝 Contributing Examples

Have a configuration for a different stack? We'd love to see it!

1. Create a directory: `examples/your-stack/`
2. Add `.claude-example/hooks.json`
3. Document any special setup in a README
4. Submit a PR!

## 📞 Need Help?

- [Main Documentation](../docs/FLEET_COMMANDER_WORKFLOW.md)
- [Contributing Guide](../CONTRIBUTING.md)
- [GitHub Discussions](https://github.com/yourusername/Fleet-Commander/discussions)

---

**Remember**: These are starting points. Customize them for your specific project needs!
