## peco-cd-ghq-repo
_peco-cd-ghq-repo() {
  local selected_dir

  selected_dir=$(ghq list -p | peco --select-1 2>/dev/null)

  if (( ! $#selected_dir )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $selected_dir"
  zle accept-line
}
zle -N peco-cd-ghq-repo _peco-cd-ghq-repo
