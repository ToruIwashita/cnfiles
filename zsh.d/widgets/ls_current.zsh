## ls-current widget
_ls-currnet() {
  local -a args
  args=("${(z)BUFFER}")
  zle -I
  ls -F --color ${args[$#args]}
}

zle -N ls-current _ls-currnet
