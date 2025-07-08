## Git Local Diff  

Command to read and analyze the diff between local branch and origin/HEAD  

### Usage  

```  
/git-local-diff  
```  

### Implementation  

When this command is called, execute the following:  

1. Run `git diff origin/HEAD...HEAD` using the Bash tool  
2. Read and analyze the diff output  
3. Provide structured summary and analysis of the changes  

### Output Format  

The command should provide:  
- **Summary**: Brief overview of changes (files modified, lines added/removed)  
- **Analysis**: Description of what was changed and potential impact  
- **Files Changed**: List of modified files with change types  
- **Key Changes**: Highlights of significant modifications  

### Examples  

```bash  
git diff origin/HEAD...HEAD  
git diff origin/HEAD...HEAD --stat  
git diff origin/HEAD...HEAD --name-only  
```  

### Error Handling  

- If `origin/HEAD` does not exist, try `git diff origin/main...HEAD` or `git diff origin/master...HEAD`  
- If no remote origin is configured, use `git diff HEAD~1...HEAD` to show recent changes  
- If no commits exist, inform the user that there are no changes to analyze  
- If git command fails, provide the error message and suggest troubleshooting steps  
