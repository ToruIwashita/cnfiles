## immediate-git-status
_immediate-git-status() {
  local cmd
  cmd='git status --short'

  if ! $(git rev-parse 2>/dev/null); then
    return 1
  fi

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-status _immediate-git-status
