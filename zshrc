# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit
# 補完メニュー選択モードのキーマップ
zmodload -i zsh/complist

# 各種設定読込
source ~/.zsh.d/zconf
source ~/.zsh.d/zconf_local
source ~/.zsh.d/ls_colors

## pathの重複登録無効
typeset -U fpath

## オートロードを使用したエセロード
# 自作関数
function_directories=(.zsh.d/zfunc .zsh.d/_zfunc .zsh.d/zfunc_local .zsh.d/_zfunc_local)
for dir in ${function_directories[@]}; do
  [ -d ~/${dir} ] || mkdir ~/${dir}
  fpath=($fpath ~/${dir})

  for file in `ls ~/${dir}`; do
    autoload -Uz ~/${dir}/${file}(:t) && ~/${dir}/${file}(:t)
  done
done

## プロンプトの定義
PROMPT="[%n]{%?}:%./%{$fg_bold[blue]%}%#%{$reset_color%} "
# vimモード識別
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
      PROMPT="[%n]{%?}:%./%{$bg_bold[blue]%}%#%{$reset_color%} " ;;
    main|viins)
      PROMPT="[%n]{%?}:%./%{$fg_bold[blue]%}%#%{$reset_color%} " ;;
  esac

  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# コンプリータ指定(通常,パターンマッチ,除外パターン復活,単語途中の補完)
zstyle ':completion:*' completer _complete _match _ignored _prefix
# 補完候補のカーソル選択有効
zstyle ':completion:*' menu true select
# 補完候補色付け
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi


