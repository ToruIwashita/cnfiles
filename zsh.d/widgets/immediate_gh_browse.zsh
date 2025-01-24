## immediate-gh-browse
_immediate-gh-browse() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER='gh browse'
  zle accept-line
}

zle -N immediate-gh-browse _immediate-gh-browse
