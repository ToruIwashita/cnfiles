## immediate-hub-browse
_immediate-hub-browse() {
  local cmd
  cmd='hub browse'

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-hub-browse _immediate-hub-browse
