## immediate-zplug-update
_immediate-zplug-update() {
  local cmd
  cmd='zplug clear && zplug update --force && ZPLUG_USE_CACHE=false zplug load --verbose'

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-zplug-update _immediate-zplug-update
