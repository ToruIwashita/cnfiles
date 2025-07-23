## AI Agent Search（AI エージェント検索）

`$AI_SEARCH_AGENT`はGoogle検索エージェントです
このコマンドが呼び出された時は,組み込みの`WebSearch`ツールの代わりにこれを使用してウェブ検索を行います

### 使用方法

```
$AI_SEARCH_AGENT -p "WebSearch: <クエリ>"
```

### 実装方法

ウェブ検索が必要な場合は,Taskツール経由で`$AI_SEARCH_AGENT -p`を使用する

### 使用例

```bash
$AI_SEARCH_AGENT -p "WebSearch: 2024年の最新TypeScript機能は何ですか？"
$AI_SEARCH_AGENT -p "WebSearch: Next.jsで認証を実装する方法は？"
$AI_SEARCH_AGENT -p "WebSearch: ソフトウェア開発における命名規則のベストプラクティス"
```

### エラーハンドリング

- `$AI_SEARCH_AGENT`が利用できない場合は,標準のウェブ検索方法にフォールバックする
- クエリが結果を返さない場合は,ユーザーに通知し代替検索語を提案する
- エージェントがエラーに遭遇した場合は,エラーメッセージをユーザーに提供する
