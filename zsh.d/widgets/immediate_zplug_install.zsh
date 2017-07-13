## immediate-zplug-install
_immediate-zplug-install() {
  local cmd
  cmd="zplug clear && zplug install"

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-zplug-install _immediate-zplug-install