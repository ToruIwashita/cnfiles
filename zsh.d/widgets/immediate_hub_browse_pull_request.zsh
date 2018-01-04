## immediate-hub-browse-pull-request
_immediate-hub-browse-pull-request() {
  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  zle push-line

  BUFFER="hub browse -- pull/$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  zle accept-line
}

zle -N immediate-hub-browse-pull-request _immediate-hub-browse-pull-request
