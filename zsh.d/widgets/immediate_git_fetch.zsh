## immediate-git-fetch
_immediate-git-fetch() {
  local cmd
  cmd='git fetch --prune'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-fetch _immediate-git-fetch
