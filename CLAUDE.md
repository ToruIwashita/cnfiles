# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a comprehensive personal dotfiles repository (.cnfiles) that manages a complete development environment setup for macOS. The repository uses git submodules to manage source code for various development tools and provides automated installation and configuration scripts.

## Essential Commands

### Initial Setup
```bash
# Initialize the entire development environment
./scripts/init.bash

# Update all git submodules
git submodule update --init
```

### Tool Installation
Individual tool installers are available in the `scripts/` directory:
- `./scripts/asdf-installer.bash` - Install asdf version manager
- `./scripts/vim-installer.bash` - Compile and install Vim from source
- `./scripts/git-installer.bash` - Compile and install Git from source
- `./scripts/tmux-installer.bash` - Install tmux terminal multiplexer
- `./scripts/zsh-installer.bash` - Install Zsh shell
- Language package installers: `gems-installer.bash`, `npms-installer.bash`, `pypies-installer.bash`, `go-package-installer.bash`

### Environment Management
- Environment variables are configured in `scripts/env.bash`
- Zsh environment setup in `zsh.d/env.zsh` and `zsh.d/env.local.zsh`
- Local customizations supported via `.local` files

## Architecture

### Directory Structure
- **`/modules/`** - Git submodules containing source code for development tools (asdf, ctags, git, vim, tmux, zsh, etc.)
- **`/scripts/`** - Installation and setup automation scripts
- **`/zsh.d/`** - Comprehensive Zsh configuration with Antigen plugin management
- **`/vim/`** - Extensive Vim/Neovim setup with 50+ plugins via vim-plug
- **`/git/`** - Git configuration (gitconfig, gitattributes, gitignore)
- **`/config/`** - Tool-specific configurations (black, flake8, karabiner, mypy)
- **`/tmux/`** - Tmux terminal multiplexer configuration
- **`/claude/`** - Claude Code IDE settings
- **`/local/`** - Local customizations and binary overrides

### Configuration Management
- **Symlink Strategy**: The init script creates symlinks from home directory to configuration files
- **Local Overrides**: Uses `.local` suffixed files for machine-specific customizations
- **Environment Variables**: Centralized environment configuration via `scripts/env.bash`
- **Modular Design**: Each tool has dedicated configuration directories

### Language Support
- **Ruby**: Managed via asdf with gem configuration
- **Python**: Python packages with flake8, black, mypy configurations
- **JavaScript/TypeScript**: npm packages with ESLint configuration
- **Go**: Go packages with delve debugger setup
- **Shell**: Advanced Zsh configuration with custom functions and completions

### Development Tools Integration
- **Version Management**: asdf for managing multiple language versions
- **Code Search**: The Silver Searcher (ag) for fast code searching
- **Git Workflow**: Extensive git aliases and configurations
- **Terminal**: tmux with custom configurations and utilities
- **Editor**: Vim/Neovim with language-specific plugins and configurations

## Claude Code Configuration

### Permission Management
**CRITICAL**: When Claude Code requests permissions for tools or file access, always add the permissions to `claude/settings.json` (the global settings file), NOT to `.claude/settings.local.json`. This ensures permissions are saved to the repository and persist across sessions.

**Process for adding permissions:**
1. When prompted for permissions, grant them
2. Immediately add the granted permissions to `claude/settings.json` in the `permissions.allow` array
3. Remove any permissions that may have been automatically added to `.claude/settings.local.json`

Example permission entries:
```json
{
  "permissions": {
    "allow": [
      "Bash(ls:*)",
      "Bash(find:*)",
      "WebFetch(domain:docs.anthropic.com)"
    ],
    "deny": []
  }
}
```

## Important Notes

- All installation scripts source `scripts/env.bash` for environment variables
- The repository is designed for macOS (Darwin) with Homebrew integration
- Local customizations should be placed in files ending with `.local`
- The system creates working directories: `~/works/`, `~/log/`, `~/.cache/`, etc.
- Memolist system for temporary files and task management in `~/works/memolist/`