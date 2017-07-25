## immediate-antigen-install
_immediate-antigen-install() {
  local cmd
  cmd='antigen reset && antigen apply && antigen cache-gen'

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-antigen-install _immediate-antigen-install
