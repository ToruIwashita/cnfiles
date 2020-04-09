## stash-save-rprompt
_stash-save-rprompt() {
  (( $#RPROMPT )) && STASHED_RPROMPT=$RPROMPT
  RPROMPT=
  zle reset-prompt
}

zle -N stash-save-rprompt _stash-save-rprompt
