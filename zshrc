## 変数
# 大文字環境変数と小文字変数を関連付け
[[ -z $ld_library_path ]] && typeset -xT LD_LIBRARY_PATH ld_library_path
[[ -z $include ]] && typeset -xT INCLUDE include

# ローカル変数
local dir file

# グローバル変数
typeset -g zsh_dir=~/.zsh.d
typeset -g zsh_plugin_dir=$zsh_dir/plugin
typeset -ga zsh_sub_dirs
typeset -ga precmd_functions
typeset -ga chpwd_functions

# typesetで配列は代入不可なので別定義
zsh_sub_dirs=(
  $zsh_dir/functions
  $zsh_dir/completions
  $zsh_dir/widgets
  $zsh_dir/completion_widgets
  $zsh_dir/local/functions
  $zsh_dir/local/completions
  $zsh_dir/local/widgets
)

# 環境変数
[[ -f $zsh_dir/env.zsh ]] && source $zsh_dir/env.zsh
[[ -f $zsh_dir/env.local.zsh ]] && source $zsh_dir/env.local.zsh

## 関数ロード
autoload -Uz colors && colors          # 色の定義
autoload -Uz compinit && compinit -u   # 自動補完
autoload -Uz zmv                       # 複数のファイルを扱うようなmv
autoload -Uz vcs_info                  # VersionControlSystem
autoload -Uz chpwd_recent_dirs         # 最近使用したdir保持
autoload -Uz chpwd_recent_filehandler  # 最近使用したdirを保持するfileの操作
autoload -Uz cdr                       # 最近使用したディレクトリを補完
autoload -Uz add-zsh-hook              # フック関数登録
autoload -Uz edit-command-line         # コマンドライン編集
zmodload -i zsh/complist               # 補完メニュー選択モードのキーマップ
zmodload -i zsh/terminfo               # terminfoの配列データを扱う(zsh-history-substring-search用にロード)

## 各種設定・オリジナル関数読込
# lib読込
for file in $zsh_dir/lib/*.zsh(.); do
  source $file
done
# 関数読込
for dir in ${zsh_sub_dirs[@]}; do
  for file in ${dir}/*.zsh(.); do
    source $file
  done
done

# 設定読込
[[ -f $zsh_dir/config.zsh ]] && source $zsh_dir/config.zsh
[[ -f $zsh_dir/config.local.zsh ]] && source $zsh_dir/config.local.zsh

# 重複パスを除去
typeset -U path fpath ld_library_path include precmd_functions chpwd_functions
