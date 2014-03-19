# utf-8

# 環境変数設定
export LANG=ja_JP.UTF-8
[[ -z $ld_library_path ]] && typeset -xT LD_LIBRARY_PATH ld_library_path
[[ -z $include ]] && typeset -xT INCLUDE include

# 定数の設定
ZSH_DIR=.zsh.d
FUNCTION_DIRS=(
  ~/$ZSH_DIR/lib
  ~/$ZSH_DIR/comp
  ~/$ZSH_DIR/local/lib
  ~/$ZSH_DIR/local/comp
)

# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit
# VersionControlSystem
autoload -Uz vcs_info
# フック関数登録
autoload -Uz add-zsh-hook
# 補完メニュー選択モードのキーマップ
zmodload -i zsh/complist

# 各種設定・関数読込
source ~/$ZSH_DIR/config.zsh
source ~/$ZSH_DIR/config.local.zsh

fpath=(${FUNCTION_DIRS} $fpath)
for dir in ${FUNCTION_DIRS[@]}; do
  for file in ${dir}/*.zsh(.); do
    autoload -Uz $file:t && $file:t
  done
done

# 重複パスを除去(パス設定が全て済んだ後に実施)
typeset -U path fpath ld_library_path include

## プロンプトの定義
# VIMモード色
VIMODE="blue"
function zle-keymap-select {
  case $KEYMAP in
    vicmd)
      VIMODE="cyan" ;;
    main|viins)
      VIMODE="blue" ;;
  esac

  zle reset-prompt
}
zle -N zle-keymap-select
# vcsの情報表示
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }
# プロンプト表示
PROMPT='_
|[${vcs_info_msg_0_}]:%~/
└-(%?)%F{$VIMODE}%#%f '
RPROMPT='[%D{%T}|%n]'

## 補完
# コンプリータ指定(通常,パターンマッチ,除外パターン復活,単語途中の補完)
zstyle ':completion:*' completer _complete _match _ignored _prefix
# 補完候補のカーソル選択有効
zstyle ':completion:*' menu true select
# 補完候補色付け
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

## CD関連自動実行関数
# cd後にls実行
function chpwd() {
  [[ $dirstack[1]:h != $PWD ]] && ls
}
