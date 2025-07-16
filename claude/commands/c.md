## Read CLAUDE.md

Command to read and display the contents of CLAUDE.md project instructions

### Usage

```
/c
```

### Implementation

When this command is called, execute the following:

1. Read the CLAUDE.md file using the Read tool
2. Display the full contents to ensure Claude Code follows the project instructions
3. Provide a brief summary of the key instructions

### Output Format

The command should provide:
- **Full Contents**: Complete CLAUDE.md file contents
- **Key Instructions**: Brief summary of critical guidelines
- **Language Setting**: Confirmation of Japanese language requirement
- **Implementation Guides**: Reminder about checking vim.md and zsh.md for specific tasks

### Purpose

This command ensures Claude Code always has access to the project instructions, especially:
- Japanese language requirement for all responses
- Mandatory implementation guide checking for Vim/Zsh tasks
- Project structure and management guidelines
- Permission management for Claude Code settings

### Error Handling

- If CLAUDE.md file does not exist, inform the user and suggest creating it
- If file is empty, notify the user of the missing instructions
- If file cannot be read, provide error message and troubleshooting steps