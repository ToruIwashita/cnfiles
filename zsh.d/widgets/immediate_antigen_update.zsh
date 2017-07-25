## immediate-antigen-update
_immediate-antigen-update() {
  local cmd
  cmd='antigen reset && antigen selfupdate && antigen update && antigen cache-gen'

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-antigen-update _immediate-antigen-update
