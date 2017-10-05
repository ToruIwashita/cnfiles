## immediate-git-reset-all
_immediate-git-reset-all() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='git reset &>/dev/null && git status --short'
  zle accept-line
}

zle -N immediate-git-reset-all _immediate-git-reset-all
