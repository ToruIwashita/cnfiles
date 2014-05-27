## start-editor
_new_start-editor() {
  emulate -L zsh
  local -a words
  words=("${(z)LBUFFER}")
  zle -I
  eval "${(q)EDITOR} ${words[$#words]} < ${(q)TTY}"
}

zle -N new-start-editor _new_start-editor
