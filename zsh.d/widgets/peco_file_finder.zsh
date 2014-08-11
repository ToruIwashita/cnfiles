## peco-file-finder
_peco-file-finder() {
  local arg
  local -aU file_path

  arg=$BUFFER
  [[ -z $arg ]] && arg='*'

  file_path=(${(f)"$(find -name "$arg" 2>/dev/null | peco 2>/dev/null)"})
  if [[ -z $file_path ]]; then
    zle beginning-of-line
    return 0
  fi

  zle kill-whole-line
  BUFFER=$file_path
  zle end-of-line
}
zle -N peco-file-finder _peco-file-finder
