## immediate-git-pull
_immediate-git-pull() {
  local cmd
  cmd="git pull origin $(git symbolic-ref HEAD --short 2>/dev/null)"

  if ! $(git rev-parse 2>/dev/null); then
    return 1
  fi

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-pull _immediate-git-pull
