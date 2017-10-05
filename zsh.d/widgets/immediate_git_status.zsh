## immediate-git-status
_immediate-git-status() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='git status --short'
  zle accept-line
}

zle -N immediate-git-status _immediate-git-status
