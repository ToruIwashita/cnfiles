# _menu_compete_files

# zstyle ':completion:*'の設定をmenu-complete-filesに反映させるため一度_genericに設定する
zle -C menu-complete-files menu-complete _generic
zstyle ':completion:menu-complete-files:*' completer _files
zstyle ':completion:menu-complete-files:*' menu select interactive
zstyle ':completion:menu-complete-files:*' list-colors ${(s.:.)LS_COLORS}
