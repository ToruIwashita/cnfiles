# utf-8
export LANG=ja_JP.UTF-8

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

# 各種設定読込
source ~/.zsh.d/config
source ~/.zsh.d/config.local

## pathの重複登録無効
typeset -U fpath

## オートロードを使用したエセロード
# 自作関数
function_directories=(.zsh.d/lib .zsh.d/completion .zsh.d/local/lib .zsh.d/local/completion)
for dir in ${function_directories[@]}; do
  [ -d ~/${dir} ] || mkdir ~/${dir}
  fpath=($fpath ~/${dir})

  for file in `ls ~/${dir}`; do
    autoload -Uz ~/${dir}/${file}(:t) && ~/${dir}/${file}(:t)
  done
done

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
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }
PROMPT='_
|[${vcs_info_msg_0_}]:%~/
└-(%?)%F{$VIMODE}%#%f '
RPROMPT='[%n|%D{%T}]'

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
function chpwd() { ls }
