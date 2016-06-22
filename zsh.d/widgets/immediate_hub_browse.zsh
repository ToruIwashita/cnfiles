## immediate-hub-browse
_immediate-hub-browse() {
  local cmd
  cmd='hub browse'

  if ! $(git rev-parse 2>/dev/null); then
    return 1
  fi

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-hub-browse _immediate-hub-browse
