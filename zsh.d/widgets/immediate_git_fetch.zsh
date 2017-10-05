## immediate-git-fetch
_immediate-git-fetch() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='git fetch --prune'
  zle accept-line
}

zle -N immediate-git-fetch _immediate-git-fetch
