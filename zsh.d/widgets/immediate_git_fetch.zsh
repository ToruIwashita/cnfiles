## immediate-git-fetch
_immediate-git-fetch() {
  local cmd
  cmd='git fetch'

  if ! $(git rev-parse 2>/dev/null); then
    return 1
  fi

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-fetch _immediate-git-fetch
