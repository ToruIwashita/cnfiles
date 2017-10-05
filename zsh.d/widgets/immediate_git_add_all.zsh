## immediate-git-add-all
_immediate-git-add-all() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='git diff && git add $(git rev-parse --show-cdup).'
  zle accept-line
}

zle -N immediate-git-add-all _immediate-git-add-all
