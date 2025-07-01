## Git Local Diff  

ローカルブランチとorigin/HEADの差分を読み込んで分析するコマンド  

### 使用法  

```  
/git-local-diff  
```  

### 実装  

このコマンドが呼ばれた時は、以下を実行：  

1. `git diff origin/HEAD...HEAD` を実行  
2. 差分の内容をClaudeに読み込ませる  
3. 変更内容の概要と分析を提供  

### コマンド実行例  

```bash  
git diff origin/HEAD...HEAD  
```  
