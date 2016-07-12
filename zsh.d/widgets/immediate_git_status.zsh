## immediate-git-status
_immediate-git-status() {
  local cmd
  cmd='git status --short'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-status _immediate-git-status
