## start-claude
_start-claude() {
  if (( ! $#BUFFER )); then
    BUFFER='claude'
  else
    BUFFER="claude -p '$BUFFER'"
  fi

  zle accept-line
}

zle -N start-claude _start-claude
