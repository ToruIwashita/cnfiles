## immediate-path-pbcopy
_immediate-path-pbcopy() {
  local cmd full_path target_path
  local -a args

  if (( $#BUFFER )); then
    args=("${(z)BUFFER}")

    if [[ "${args[$#args]}" = /* ]]; then
      full_path="${(A)args[$#args]}"
    else
      full_path="${(A)PWD}/${args[$#args]}"
    fi

    if [[ ! -e "$full_path" ]]; then
      zle beginning-of-line
      return
    fi

    cmd="echo -n ${(q)${full_path/#$HOME/~}} | pbcopy"
  else
    cmd="echo -n ${(q)${PWD/#$HOME/~}} | pbcopy"
  fi

  zle -I
  print -s ${(q)cmd} && eval $cmd
  print "copied to clipboard: $(pbpaste)"
}

zle -N immediate-path-pbcopy _immediate-path-pbcopy
