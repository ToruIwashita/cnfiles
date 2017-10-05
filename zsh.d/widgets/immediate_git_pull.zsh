## immediate-git-pull
_immediate-git-pull() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER="git pull origin $(git symbolic-ref HEAD --short 2>/dev/null)"
  zle accept-line
}

zle -N immediate-git-pull _immediate-git-pull
