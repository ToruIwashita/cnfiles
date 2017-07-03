## immediate-zplug-clean
_immediate-zplug-clean() {
  local cmd
  cmd='zplug clear && zplug clean --force && ZPLUG_USE_CACHE=false zplug load --verbose'

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-zplug-clean _immediate-zplug-clean
