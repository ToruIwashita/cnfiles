## 変数
# 大文字環境変数と小文字変数を関連付け
[[ -z $ld_library_path ]] && typeset -xT LD_LIBRARY_PATH ld_library_path
[[ -z $include ]] && typeset -xT INCLUDE include

# ローカル変数
local dir_path file_path

# グローバル変数
typeset -g zsh_dir_path=~/.zsh.d
typeset -g zsh_inits_dir_path=$zsh_dir_path/inits
typeset -g zsh_local_dir_path=$zsh_dir_path/local
typeset -g zsh_plugin_dir_path=$zsh_dir_path/plugin
typeset -ga zsh_lib_dir_paths
typeset -ga zsh_sub_dir_paths
typeset -ga precmd_functions
typeset -ga chpwd_functions

# 配列はtypesetで代入不可なので別定義
zsh_lib_dir_paths=(
  $zsh_dir_path/lib
  $zsh_local_dir_path/lib
)

zsh_sub_dir_paths=(
  $zsh_dir_path/functions
  $zsh_dir_path/completions
  $zsh_dir_path/widgets
  $zsh_dir_path/completion_widgets
  $zsh_local_dir_path/functions
  $zsh_local_dir_path/completions
  $zsh_local_dir_path/widgets
)

# 環境変数
[[ -f $zsh_dir_path/env.zsh ]] && source $zsh_dir_path/env.zsh
[[ -f $zsh_dir_path/env.local.zsh ]] && source $zsh_dir_path/env.local.zsh

## 関数ロード
# 組み込み系
autoload -Uz colors && colors          # 色の定義
autoload -Uz compinit && compinit -u   # 自動補完
autoload -Uz zmv                       # 複数のファイルを扱うようなmv
autoload -Uz vcs_info                  # VersionControlSystem
autoload -Uz chpwd_recent_dirs         # 最近使用したdir保持
autoload -Uz chpwd_recent_filehandler  # 最近使用したdirを保持するfileの操作
autoload -Uz cdr                       # 最近使用したディレクトリを補完
autoload -Uz add-zsh-hook              # フック関数登録
autoload -Uz edit-command-line         # コマンドライン編集
zmodload zsh/complist                  # 補完メニュー選択モードのキーマップ
zmodload zsh/terminfo                  # terminfoの配列データを扱う(zsh-history-substring-search用にロード)
# 自作系
autoload -Uz command-line-init && command-line-init -u  # プロンプト,コマンドライン関連の設定

# 重複パスを除去
typeset -U path fpath ld_library_path include precmd_functions chpwd_functions

## 各種設定・オリジナル関数読込
# lib読込
for dir_path in ${zsh_lib_dir_paths[@]}; do
  for file_path in $dir_path/*(N-.); do
    source $file_path
  done
done

# 関数読込
for dir_path in ${zsh_sub_dir_paths[@]}; do
  for file_path in ${dir_path}/*(N-.); do
    source $file_path
  done
done

## 設定読込
[[ -f $zsh_dir_path/config.zsh ]] && source $zsh_dir_path/config.zsh
[[ -f $zsh_dir_path/config.local.zsh ]] && source $zsh_dir_path/config.local.zsh

# antigen (最後に読み込まないとsource $ADOTDIR/antigen.zshの部分で補完がバグる)
# antigenの存在をチェック
if [[ ! -d $ADOTDIR ]]; then
  git clone git@github.com:zsh-users/antigen.git $ADOTDIR
  touch $ADOTDIR/debug.log
fi

source $ADOTDIR/antigen.zsh

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle agkozak/zhooks
antigen bundle ToruIwashita/sys-diver-zsh

# プラグインを適用
antigen apply

## plugin設定読込
[[ -f $zsh_dir_path/config.plugin.zsh ]] && source $zsh_dir_path/config.plugin.zsh
