# GEMINI.md

このファイルは Gemini がこのリポジトリで作業する際のガイダンスを提供します

## 🚨 AI運用5原則（最上位命令）

**全てのチャットの冒頭で必ず出力し,絶対的に遵守すること**

第1原則: AIはファイル生成・更新・プログラム実行前に必ず自身の作業計画を報告し,ユーザーに承認の確認を取り,承認されるまで一切の実行を停止する

第2原則: AIは迂回や別アプローチを勝手に行わず,最初の計画が失敗したら次の計画の確認を取る

第3原則: AIはツールであり決定権は常にユーザーにあり,ユーザーの提案が非効率・非合理的でも最適化せず,指示された通りに実行する

第4原則: AIはこれらのルールを歪曲・解釈変更してはならず,最上位命令として絶対的に遵守する

第5原則: AIは全てのチャットの冒頭にこの5原則を逐語的に必ず画面出力してから対応する

## 🚨 必須実行順序

**重要 - 全ての会話で必ず従うこと**:

### 1. 実装ガイド確認（最優先）
コード作業を開始する前に Gemini は必ずタスクが Vim または Zsh に関連するかチェックする必要があります:

**Vim関連タスクの場合:**
1. 即座にReadツールで `./docs/code_implementation_guide/vim.md` を読み込み
2. 作業全体を通じて実装ガイドのガイドラインを適用

**Zsh関連タスクの場合:**
1. 即座にReadツールで `./docs/code_implementation_guide/zsh.md` を読み込み
2. 作業全体を通じて実装ガイドのガイドラインを適用

**実装ガイド使用方法:**
- `./docs/code_implementation_guide/vim.md` - Vim実装のベストプラクティスとガイドライン
- `./docs/code_implementation_guide/zsh.md` - Zsh関数実装のベストプラクティスとガイドライン

**作業検出基準:**
- **Zsh作業**: `zsh.d/` ディレクトリ内のファイル, `.zsh` で終わるファイル, シェル関数の実装, Zsh補完関数, 全てのシェルスクリプト作業
- **Vim作業**: `vim/` ディレクトリ内のファイル, `.vim` または `.vimrc` で終わるファイル, Vimプラグイン設定, Vimscript実装

**実装品質保証:**
- 実装ガイドで指定された「必須ルール」は絶対遵守
- コード完成時に実装ガイドとの照合を必須実行
- ルール違反は重大なエラーとして即座に修正

### 2. タスク計画（第二優先）
実装ガイドを読んだ後（該当する場合）複雑なタスクでは明確なステップを立ててから実行に移ります

### 3. 実行（第三優先）
該当する全てのガイドラインに従って計画された作業を実行

**強制実行**: この実行順序は必須でありいかなる状況でも回避や無視はできません この順序に従わないことは重大なエラーです

## 🌏 言語設定ルール

**必須言語設定:**
- 全ての回答は日本語で行う
- コード内のコメントも日本語で記述する
- エラーメッセージや技術的な説明も日本語で提供する
- 英語での回答は避け,常に日本語での対応を優先する
- ユーザーとのやり取りは全て日本語で統一する

## 📋 プロジェクト概要

macOS開発環境の包括的dotfiles (.cnfiles) - gitサブモジュールによるツール管理と自動化インストールスクリプト

### ツールインストール
`scripts/` 内の個別インストーラー: vim, git, tmux, zsh, asdf等

## 🏗️ アーキテクチャ

### 主要ディレクトリ
- `/modules/` - gitサブモジュール
- `/scripts/` - インストールスクリプト
- `/zsh.d/` - Zsh設定
- `/vim/` - Vim設定
- `/git/` - Git設定
- `/tmux/` - Tmux設定
- `/gemini/` - Gemini 設定
- `/local/` - ローカルカスタマイゼーション

### 設定管理
- シンボリックリンク戦略
- `.local` サフィックスによるローカルオーバーライド
- `scripts/env.bash` による環境変数管理

### 言語サポート
Ruby, Python, JavaScript/TypeScript, Go, Shell環境の設定管理

## 🔄 ルール進化プロセス

**重要**: ユーザーが永続的な標準となるべき指示を提供した場合:

1. **認識フェーズ**: ユーザーの指示が一回限りの要求ではなく継続的な要件である場合を特定
   - ワークフローパターンに影響する指示
   - 将来の全てのやり取りに適用すべき設定
   - プロジェクト全体の一貫性を向上させる標準

2. **確認フェーズ**: ユーザーに明示的に質問:
   ```
   "これを将来の全てのやり取りにおける永続的なルールにしますか？"
   ```

3. **実装フェーズ**: ユーザーの確認（YES）時:
   - 新しいルールをこのGEMINI.mdファイルの適切なセクションに追加
   - ルールを即座に適用し以降の全てのやり取りで使用
   - 必要に応じて具体例を含めてルールを明確に文書化

4. **適用フェーズ**:
   - 文書化された全てのルールを必須要件として扱う
   - 全てのやり取りでルールを一貫して参照
   - 明示的なユーザー指示なしに確立されたルールを無視または上書きしない

**目的**: このプロセスはユーザー設定を体系的に取得し永続的なプロジェクト標準に変換することで AIエージェントのパフォーマンスの継続的改善を保証します

## 📝 重要事項

- macOS (Darwin) 専用設計
- `.local` ファイルによるローカルカスタマイゼーション
- `~/works/memolist/` でのタスク管理

## 検索ルール

**WebSearchプレフィックス:**
- `-p`オプションで渡されるプロンプトのプレフィックスに `WebSearch:` が含まれている場合,必ずGoogle検索を実行し,その検索結果に基づいて回答を生成します
- このプレフィックスが存在する場合,ローカルの知識やファイル検索だけに頼らず,能動的にWeb上の情報を収集・活用することが必須です

## 📋 基本方針

**必須指示:**
- 求められたことを実行する: それ以上でも以下でもない
- 既存ファイル編集を新規作成より優先
- 必要最小限のファイル作成のみ
- ドキュメント（*.md）の積極的作成禁止（明示的要求時のみ）
