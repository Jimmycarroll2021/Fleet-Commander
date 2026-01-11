# Fleet Commander Setup Guide

Complete setup instructions for different operating systems and environments.

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [macOS Setup](#macos-setup)
- [Linux Setup](#linux-setup)
- [Windows (WSL2) Setup](#windows-wsl2-setup)
- [Docker Setup](#docker-setup)
- [CI/CD Integration](#cicd-integration)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software

1. **Claude Code CLI**
   - Installation: [https://docs.anthropic.com/claude/docs/claude-code](https://docs.anthropic.com/claude/docs/claude-code)
   - Verify: `claude-code --version`

2. **Git**
   - Version 2.30+
   - Verify: `git --version`

3. **jq** (JSON processor)
   - Used by fleet manager scripts
   - Auto-installed by quick-start script

### Recommended Software

- **Terminal Multiplexer**: iTerm2 (macOS), Ghostty, or tmux
- **GitHub CLI**: `gh` for PR creation (`brew install gh` or similar)
- **Text Editor**: VS Code, vim, or your preferred editor

---

## macOS Setup

### 1. Install Homebrew (if not installed)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Dependencies

```bash
# Install jq
brew install jq

# Install GitHub CLI (optional, for PR creation)
brew install gh

# Authenticate GitHub CLI
gh auth login
```

### 3. Install Claude Code

```bash
# Follow Claude Code installation instructions
# https://docs.anthropic.com/claude/docs/claude-code
```

### 4. Clone and Setup Fleet Commander

```bash
# Clone repository
git clone https://github.com/yourusername/Fleet-Commander.git
cd Fleet-Commander

# Run setup
./scripts/quick-start.sh

# Customize for your project
cp CLAUDE.md CLAUDE.md.backup
vim CLAUDE.md
```

### 5. Configure Terminal

#### iTerm2 Setup

1. **Install iTerm2**: `brew install --cask iterm2`

2. **Configure Profiles**:
   - Preferences → Profiles → Create 5 profiles named "Fleet 1" through "Fleet 5"
   - Set hotkeys: ⌘1 through ⌘5 for quick switching

3. **Enable Notifications**:
   - Preferences → Profiles → Terminal → Notifications
   - Check "Notify when a terminal is idle"

4. **Create Startup Script**:

```bash
# ~/.fleet-commander-start.sh
#!/bin/bash

# Open 5 iTerm2 tabs
osascript <<EOF
tell application "iTerm"
    tell current window
        repeat 4 times
            create tab with default profile
        end repeat
    end tell
end tell
EOF
```

### 6. Test Installation

```bash
# Test fleet manager
./scripts/fleet-manager.sh status

# Test Claude Code
claude-code --version

# Test hooks
.claude/hooks/post-tool-use.sh README.md Write
```

---

## Linux Setup

### Ubuntu/Debian

```bash
# Update package list
sudo apt-get update

# Install jq
sudo apt-get install -y jq

# Install GitHub CLI (optional)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
  sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install -y gh

# Install Claude Code
# Follow official documentation

# Clone Fleet Commander
git clone https://github.com/yourusername/Fleet-Commander.git
cd Fleet-Commander

# Run setup
./scripts/quick-start.sh
```

### Fedora/RHEL/CentOS

```bash
# Install jq
sudo dnf install -y jq

# Install GitHub CLI
sudo dnf install -y gh

# Continue with Fleet Commander setup
git clone https://github.com/yourusername/Fleet-Commander.git
cd Fleet-Commander
./scripts/quick-start.sh
```

### Arch Linux

```bash
# Install dependencies
sudo pacman -S jq github-cli

# Setup Fleet Commander
git clone https://github.com/yourusername/Fleet-Commander.git
cd Fleet-Commander
./scripts/quick-start.sh
```

### Configure Notifications (Linux)

```bash
# Install notify-send (if not present)
sudo apt-get install -y libnotify-bin  # Ubuntu/Debian
sudo dnf install -y libnotify           # Fedora

# Test notification
notify-send "Fleet Commander" "Notification test"
```

---

## Windows (WSL2) Setup

### 1. Enable WSL2

```powershell
# Run in PowerShell as Administrator
wsl --install
```

### 2. Install Ubuntu in WSL2

```powershell
wsl --install -d Ubuntu-22.04
```

### 3. Setup in WSL2

```bash
# Launch Ubuntu
wsl

# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y jq git curl

# Install Claude Code
# Follow official documentation

# Clone Fleet Commander
git clone https://github.com/yourusername/Fleet-Commander.git
cd Fleet-Commander

# Run setup
./scripts/quick-start.sh
```

### 4. Configure Windows Terminal

1. **Install Windows Terminal** (from Microsoft Store)

2. **Create Profiles**:
   - Settings → Profiles → Add new profile
   - Create 5 profiles for fleet instances

3. **Keyboard Shortcuts**:
   - Settings → Actions
   - Map Ctrl+1 through Ctrl+5 to switch profiles

### 5. Enable Notifications

```bash
# Install WSL notification tool
curl -L https://github.com/wslutilities/wslu/releases/latest/download/wslu-ubuntu.tar.gz | \
  tar xz && sudo ./install.sh

# Test notification
wsl-notify-send.exe "Fleet Commander" "Test notification"
```

---

## Docker Setup

For isolated environments or team consistency.

### 1. Create Dockerfile

```dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    jq \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code
# Follow official installation steps

# Create working directory
WORKDIR /workspace

# Copy Fleet Commander
COPY . /workspace/fleet-commander

# Initialize Fleet Commander
RUN cd /workspace/fleet-commander && \
    chmod +x scripts/*.sh .claude/hooks/*.sh

CMD ["/bin/bash"]
```

### 2. Build and Run

```bash
# Build image
docker build -t fleet-commander .

# Run container with volume mount
docker run -it -v $(pwd):/workspace fleet-commander

# Inside container
cd /workspace/fleet-commander
./scripts/quick-start.sh
```

### 3. Docker Compose (for persistent development)

```yaml
# docker-compose.yml
version: '3.8'

services:
  fleet-commander:
    build: .
    volumes:
      - ./:/workspace
      - ~/.claude:/root/.claude
    working_dir: /workspace
    command: /bin/bash
    stdin_open: true
    tty: true
```

```bash
# Start environment
docker-compose up -d

# Attach to container
docker-compose exec fleet-commander bash
```

---

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/fleet-commander-verify.yml
name: Fleet Commander Verification

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  verify:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Setup dependencies
      run: |
        sudo apt-get update
        sudo apt-get install -y jq

    - name: Initialize Fleet Commander
      run: |
        chmod +x scripts/*.sh .claude/hooks/*.sh
        ./scripts/quick-start.sh

    - name: Run verification
      run: |
        # Run your project-specific tests
        # This depends on your tech stack
        echo "Running verification..."
```

### GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - setup
  - verify

setup_fleet:
  stage: setup
  script:
    - apt-get update && apt-get install -y jq
    - chmod +x scripts/*.sh .claude/hooks/*.sh
    - ./scripts/quick-start.sh
  artifacts:
    paths:
      - .claude/fleet/

verify_project:
  stage: verify
  dependencies:
    - setup_fleet
  script:
    - ./scripts/fleet-manager.sh status
    - # Run your tests here
```

---

## Troubleshooting

### Common Issues

#### Issue: `jq: command not found`

**Solution**:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install -y jq

# Fedora
sudo dnf install -y jq
```

#### Issue: Hooks not executing

**Solution**:
```bash
# Make hooks executable
chmod +x .claude/hooks/*.sh

# Verify permissions
ls -la .claude/hooks/
```

#### Issue: Notifications not working (macOS)

**Solution**:
1. System Preferences → Notifications
2. Find your terminal app (iTerm2, Terminal, etc.)
3. Enable "Allow Notifications"

#### Issue: Notifications not working (Linux)

**Solution**:
```bash
# Install notify-send
sudo apt-get install -y libnotify-bin

# Test
notify-send "Test" "This is a test notification"

# Check if notification daemon is running
ps aux | grep notify
```

#### Issue: `claude-code: command not found`

**Solution**:
```bash
# Verify Claude Code installation
which claude-code

# If not found, reinstall following official docs
# https://docs.anthropic.com/claude/docs/claude-code

# Check PATH
echo $PATH
```

#### Issue: Fleet manager shows "Not initialized"

**Solution**:
```bash
# Re-initialize fleet
./scripts/fleet-manager.sh init

# Verify initialization
ls -la .claude/fleet/
```

### Getting Help

1. **Check Documentation**:
   - [Main README](../README.md)
   - [Workflow Guide](FLEET_COMMANDER_WORKFLOW.md)
   - [Contributing Guide](../CONTRIBUTING.md)

2. **Search Issues**:
   - [GitHub Issues](https://github.com/yourusername/Fleet-Commander/issues)

3. **Ask Questions**:
   - [GitHub Discussions](https://github.com/yourusername/Fleet-Commander/discussions)

4. **Report Bugs**:
   - [Submit Bug Report](https://github.com/yourusername/Fleet-Commander/issues/new?template=bug_report.md)

---

## Next Steps

After setup:

1. ✅ Customize `CLAUDE.md` for your project
2. ✅ Configure hooks for your tech stack
3. ✅ Test custom slash commands
4. ✅ Open 5 terminal tabs and start your fleet
5. ✅ Assign your first parallel tasks

**Ready to command your fleet!** 🚀
