## immediate-gh-browse-pull-request
_immediate-gh-browse-pull-request() {
  local branch

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle -I
    return
  fi

  if (( $#BUFFER )); then
    branch=$BUFFER
  else
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  fi

  zle push-line

  BUFFER="gh pr view --web $branch || gh pr create --web --head $branch"

  zle accept-line
}

zle -N immediate-gh-browse-pull-request _immediate-gh-browse-pull-request
