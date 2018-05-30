## peco-cd-ghq-repo
_peco-cd-ghq-repo() {
  local -aU dir_paths

  dir_paths=(${(f)"$(ghq list -p | peco --select-1 2>/dev/null)"})

  if (( ! $#dir_paths )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $dir_paths"
  zle accept-line
}
zle -N peco-cd-ghq-repo _peco-cd-ghq-repo
