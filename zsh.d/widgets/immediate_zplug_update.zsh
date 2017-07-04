## immediate-zplug-update
_immediate-zplug-update() {
  local cmd
  cmd='zplug clear && zplug update --force'

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-zplug-update _immediate-zplug-update
