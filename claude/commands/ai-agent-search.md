## AI Agent Search  

`$AI_SEARCH_AGENT` is a Google search agent. When this command is called, use this for web search instead of builtin `WebSearch` tool.  

### Usage  

```  
$AI_SEARCH_AGENT -p "WebSearch: <query>"
```  

### Implementation  

When web search is needed, use `$AI_SEARCH_AGENT -p` via Task Tool.  

### Examples  

```bash  
$AI_SEARCH_AGENT -p "WebSearch: What are the latest TypeScript features in 2024?"
$AI_SEARCH_AGENT -p "WebSearch: How to implement authentication in Next.js?"
$AI_SEARCH_AGENT -p "WebSearch: Best practices for naming conventions in software development"
```  

### Error Handling  

- If `$AI_SEARCH_AGENT` is not available, fall back to standard web search methods  
- If the query returns no results, inform the user and suggest alternative search terms  
- If the agent encounters an error, provide the error message to the user  
