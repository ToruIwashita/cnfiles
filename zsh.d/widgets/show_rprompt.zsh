## show-rprompt
_show-rprompt() {
  (( $#STASHED_RPROMPT )) && RPROMPT=$STASHED_RPROMPT
  STASHED_RPROMPT=
  zle reset-prompt
}

zle -N show-rprompt _show-rprompt
