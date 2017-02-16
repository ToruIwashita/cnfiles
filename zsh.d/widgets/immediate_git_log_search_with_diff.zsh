## immediate-git-log-search-with-diff
_immediate-git-log-search-with-diff() {
  if (( $#BUFFER )); then
    print -s "$BUFFER"
  else
    zle beginning-of-line
    return
  fi

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle beginning-of-line
    return
  fi

  zle -I
  git log -p -S $BUFFER
}

zle -N immediate-git-log-search-with-diff _immediate-git-log-search-with-diff
