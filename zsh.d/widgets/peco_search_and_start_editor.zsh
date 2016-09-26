## peco-search-and-start-editor
_peco-search-and-start-editor() {
  local cmd context parttern specified_line
  local -a args peco_resulting_line
  local -aU file_paths

  (( $#BUFFER )) && print -s "$BUFFER"

  args=("${(z)BUFFER}")
  if (( $#args >= 2 )) && [[ ${args[-1]} =~ '^[0-9]*$' ]]; then
    context="--context=${args[-1]}"
    pattern=${args:0:-1}
  else
    context=''
    pattern=$args
  fi

  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]; then
    peco_resulting_line=(${(f)"$(git grep --line-number $context "$pattern" | peco --select-1 2>/dev/null)"})
  else
    peco_resulting_line=(${(f)"$(ag --silent $context "$pattern" | peco --select-1 2>/dev/null)"})
  fi

  if (( ! $#peco_resulting_line )); then
    zle beginning-of-line
    return
  fi

  if (( $#peco_resulting_line == 1 )); then
    specified_line=+${${(M)${(M)peco_resulting_line#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}//[:-]/}
    file_paths=${(R)${(M)peco_resulting_line#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}
  else
    specified_line=''
    file_paths=${(R)${(M)peco_resulting_line#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}
  fi

  BUFFER="${EDITOR:-vim} $file_paths $specified_line"
  zle accept-line
}

zle -N peco-search-and-start-editor _peco-search-and-start-editor
