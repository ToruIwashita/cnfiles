## immediate-git-log-search
_immediate-git-log-search() {
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
  git log -S $BUFFER
}

zle -N immediate-git-log-search _immediate-git-log-search
