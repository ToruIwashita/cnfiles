## immediate-hub-browse-pull-request
_immediate-hub-browse-pull-request() {
  local branch

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  branch=$BUFFER

  zle push-line

  if (( $#branch )); then
    BUFFER="hub browse -- pull/$branch"
  else
    BUFFER="hub browse -- pull/$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  fi

  zle accept-line
}

zle -N immediate-hub-browse-pull-request _immediate-hub-browse-pull-request
