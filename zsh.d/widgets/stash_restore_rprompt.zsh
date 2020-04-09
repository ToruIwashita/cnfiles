## stash-restore-rprompt
_stash-restore-rprompt() {
  (( $#STASHED_RPROMPT )) && RPROMPT=$STASHED_RPROMPT
  STASHED_RPROMPT=
  zle reset-prompt
}

zle -N stash-restore-rprompt _stash-restore-rprompt
