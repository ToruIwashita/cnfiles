## immediate-git-diff
_immediate-git-diff() {
  local cmd
  cmd='git diff'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-diff _immediate-git-diff
