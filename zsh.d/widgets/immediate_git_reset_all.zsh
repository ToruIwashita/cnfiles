## immediate-git-reset-all
_immediate-git-reset-all() {
  local cmd
  cmd='git reset &>/dev/null && git status --short'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-reset-all _immediate-git-reset-all
