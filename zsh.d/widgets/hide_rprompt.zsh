## hide-rprompt
_hide-rprompt() {
  (( $#RPROMPT )) && STASHED_RPROMPT=$RPROMPT
  RPROMPT=
  zle reset-prompt
}

zle -N hide-rprompt _hide-rprompt
