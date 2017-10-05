## immediate-git-diff
_immediate-git-diff() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='git diff'
  zle accept-line
}

zle -N immediate-git-diff _immediate-git-diff
