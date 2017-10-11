## immediate-git-log-search
_immediate-git-log-search() {
  if (( ! $#BUFFER )); then
    zle beginning-of-line
    return
  fi

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle beginning-of-line
    return
  fi

  BUFFER="git log -S $BUFFER"
  zle accept-line
}

zle -N immediate-git-log-search _immediate-git-log-search
