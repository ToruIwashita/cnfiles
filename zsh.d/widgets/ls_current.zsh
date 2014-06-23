## ls-current
_ls-current() {
  zle -I
  ls
}

zle -N ls-current _ls-current
