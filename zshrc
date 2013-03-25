# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit
# 補完メニュー選択モードのキーマップ
zmodload -i zsh/complist

# 各種設定読込
[ -f ~/.zsh.d/zconf ] || touch ~/.zsh.d/zconf && source ~/.zsh.d/zconf
[ -f ~/.zsh.d/zconf_local ] || touch ~/.zsh.d/zconf_local && source ~/.zsh.d/zconf_local
[ -f ~/.zsh.d/ls_colors ] || touch ~/.zsh.d/ls_colors && source ~/.zsh.d/ls_colors

## オートロード
# 自作関数
function_directories=(.zsh.d/zfunc .zsh.d/zfunc_local)
for dir in ${function_directories[@]}; do
  [ -d ~/${dir} ] || mkdir ~/${dir}
  fpath=($fpath ~/${dir})

  for file in `ls ~/${dir}`; do
    autoload -Uz ~/${dir}/${file}(:t) && ~/${dir}/${file}(:t)
  done
done

## pathの重複登録無効
typeset -U fpath

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

# 補完候補のカーソル選択有効
zstyle ':completion:*:default' menu true select
# 補完候補色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
