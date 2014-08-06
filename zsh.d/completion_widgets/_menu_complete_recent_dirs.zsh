# _menu_complete_recent_dirs
__complete-recent-dirs() {
  local -a recent_dirs
  if (( ${+functions[cdr]} )); then
    recent_dirs=(${^${(f)"$(cdr -l)"}##*[[:space:]]}/)
  else
    recent_dirs=()
  fi
  echo $recent_dirs
  compadd -Q -a recent_dirs
}

zle -C menu-complete-recent-dirs menu-complete _generic
zstyle ':completion:menu-complete-recent-dirs:*' completer __complete-recent-dirs
