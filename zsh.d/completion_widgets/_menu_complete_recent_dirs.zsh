# _menu_complete_recent_dirs
__complete-recent-dirs() {
  local -a recent_dirs
  if (( ${+functions[cdr]} )); then
    recent_dirs=(${^${(f)"$(cdr -l)"}##<-> ##}/)
  else
    recent_dirs=()
  fi
  _wanted -V recent-dirs expl 'recent-dirs' compadd -S '' -Q -a recent_dirs
}

zle -C menu-complete-recent-dirs menu-complete _generic
zstyle ':completion:menu-complete-recent-dirs:*' completer __complete-recent-dirs
