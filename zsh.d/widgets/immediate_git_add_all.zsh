## immediate-git-add-all
_immediate-git-add-all() {
  local cmd
  cmd='git diff && git add $(git rev-parse --show-cdup).'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-add-all _immediate-git-add-all
