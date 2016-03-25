## 変数設定
local zsh_dir zsh_plugin_dir zsh_completions_src zsh_history_substring_search_src zsh_golang_misc_src dir file
local -a zsh_function_dirs
# グローバル変数
typeset -ga precmd_functions
typeset -ga chpwd_functions

zsh_dir=~/.zsh.d
zsh_plugin_dir=$zsh_dir/plugin
zsh_function_dirs=(
  $zsh_dir/functions
  $zsh_dir/completions
  $zsh_dir/widgets
  $zsh_dir/completion_widgets
  $zsh_dir/local/functions
  $zsh_dir/local/completions
  $zsh_dir/local/widgets
)

## LD_LIBRARY_PATH,INCLUDE関連付け
[[ -z $ld_library_path ]] && typeset -xT LD_LIBRARY_PATH ld_library_path
[[ -z $include ]] && typeset -xT INCLUDE include

# plugin path
zsh_completions_src=$zsh_plugin_dir/zsh-completions/zsh-completions.plugin.zsh
zsh_history_substring_search_src=$zsh_plugin_dir/zsh-history-substring-search/zsh-history-substring-search.zsh
zsh_golang_misc_src=$zsh_plugin_dir/golang-misc-zsh/src/go.zsh

## plugin読み込み
[[ -f $zsh_completions_src ]] && source $zsh_completions_src
[[ -f $zsh_history_substring_search_src ]] && source $zsh_history_substring_search_src
[[ -f $zsh_golang_misc_src ]] && source $zsh_golang_misc_src

## path関連設定
# fpath設定,ディレクトリ読み込みplugin追加
fpath=($zsh_function_dirs $fpath)

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
# 関数読込
for dir in ${zsh_function_dirs[@]}; do
  for file in ${dir}/*.zsh(.); do
    autoload -Uz $file:t && $file:t
  done
done

# 設定読込
[[ -f $zsh_dir/config.zsh ]] && source $zsh_dir/config.zsh
[[ -f $zsh_dir/config.local.zsh ]] && source $zsh_dir/config.local.zsh

# 重複パスを除去
typeset -U path fpath ld_library_path include precmd_functions chpwd_functions
