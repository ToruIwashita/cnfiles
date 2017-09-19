## immediate-git-add-all
_immediate-git-add-all() {
  local cmd
  cmd='git add $(git rev-parse --show-cdup). && git status --short'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-add-all _immediate-git-add-all
