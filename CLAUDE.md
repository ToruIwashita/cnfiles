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

### Settings File Hierarchy
Claude Code uses two levels of configuration:

1. **Repository-specific settings**: `claude/settings.json` (tracked in git)
   - Project-specific permissions and configurations
   - Shared across all users of this repository

2. **User-global settings**: `~/.claude/settings.json` (not tracked in git)
   - Personal preferences like theme, global permissions
   - User-specific environment variables and configurations

### Permission Management
**CRITICAL**: When Claude Code requests permissions for tools or file access, add them to the appropriate settings file:

- **Project permissions** → `claude/settings.json` (repository-specific tools and workflows)
- **Global permissions** → `~/.claude/settings.json` (personal preferences, system-wide tools)

**Process for adding permissions:**
1. When prompted for permissions, grant them
2. Add project-related permissions to `claude/settings.json` in the `permissions.allow` array
3. Add user-global permissions to `~/.claude/settings.json`
4. **IMPORTANT**: Always remove any permissions that may have been automatically added to `.claude/settings.local.json` and move them to the appropriate global or project settings file

Example project permission entries (`claude/settings.json`):
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

Example user-global settings (`~/.claude/settings.json`):
```json
{
  "theme": "dark",
  "permissions": {
    "allow": [
      "Bash(system-wide-command:*)"
    ]
  }
}
```

## Additional Resources

### Implementation Guides
**CRITICAL**: When working on Vim or Zsh implementations, you MUST immediately read the relevant implementation guide files specified by these environment variables:

- `$MARKDOWN_TEXTS_VIM_IMPLEMENTATION_GUIDE_FILE_PATH` - Vim implementation best practices and guidelines
- `$MARKDOWN_TEXTS_ZSH_IMPLEMENTATION_GUIDE_FILE_PATH` - Zsh function implementation best practices and guidelines

**Startup procedure for Vim work:**
1. Get the value of `$MARKDOWN_TEXTS_VIM_IMPLEMENTATION_GUIDE_FILE_PATH` using the Bash tool
2. Read the implementation guide file using the Read tool
3. Follow the guidelines throughout your Vim-related work

**Startup procedure for Zsh work:**
1. Get the value of `$MARKDOWN_TEXTS_ZSH_IMPLEMENTATION_GUIDE_FILE_PATH` using the Bash tool
2. Read the implementation guide file using the Read tool
3. Follow the guidelines throughout your Zsh-related work

**Usage instructions:**
- These guides contain critical implementation patterns and best practices
- Always reference these guides before implementing Vim plugins or Zsh functions
- The content from these files should be considered as important as the CLAUDE.md instructions

## Rule Evolution Process

**CRITICAL**: When users provide instructions that should become permanent standards:

1. **Recognition Phase**: Identify when user instructions appear to be ongoing requirements rather than one-time requests
   - Instructions that affect workflow patterns
   - Preferences that should apply to all future interactions
   - Standards that improve overall project consistency

2. **Confirmation Phase**: Ask the user explicitly:
   ```
   "Should this become a permanent rule for all future interactions?"
   ```

3. **Implementation Phase**: Upon user confirmation (YES):
   - Add the new rule to this CLAUDE.md file under the appropriate section
   - Apply the rule immediately and for all subsequent interactions
   - Ensure the rule is clearly documented with specific examples when applicable

4. **Application Phase**:
   - Treat all documented rules as mandatory requirements
   - Reference rules consistently across all interactions
   - Never ignore or override established rules without explicit user instruction

**Purpose**: This process ensures continuous improvement of AI agent performance by systematically capturing user preferences and converting them into permanent project standards.

## Important Notes

- All installation scripts source `scripts/env.bash` for environment variables
- The repository is designed for macOS (Darwin) with Homebrew integration
- Local customizations should be placed in files ending with `.local`
- The system creates working directories: `~/works/`, `~/log/`, `~/.cache/`, etc.
- Memolist system for temporary files and task management in `~/works/memolist/`
