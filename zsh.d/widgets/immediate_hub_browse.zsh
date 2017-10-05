## immediate-hub-browse
_immediate-hub-browse() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='hub browse'
  zle accept-line
}

zle -N immediate-hub-browse _immediate-hub-browse
