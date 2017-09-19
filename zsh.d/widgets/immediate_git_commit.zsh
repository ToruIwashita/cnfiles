## immediate-git-commit
_immediate-git-commit() {
  ( ! $(git rev-parse 2>/dev/null) ) && return

  BUFFER="git commit"
  zle accept-line
}

zle -N immediate-git-commit _immediate-git-commit
