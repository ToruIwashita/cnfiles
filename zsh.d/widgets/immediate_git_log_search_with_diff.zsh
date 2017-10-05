## immediate-git-log-search-with-diff
_immediate-git-log-search-with-diff() {
  if (( ! $#BUFFER )); then
    zle beginning-of-line
    return
  fi

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle beginning-of-line
    return
  fi

  zle push-line

  BUFFER="git log -p -S $BUFFER"
  zle accept-line
}

zle -N immediate-git-log-search-with-diff _immediate-git-log-search-with-diff
