## immediate-antigen-clean
_immediate-antigen-clean() {
  local cmd
  cmd='antigen reset && antigen cleanup && antigen cache-gen'

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-antigen-clean _immediate-antigen-clean
