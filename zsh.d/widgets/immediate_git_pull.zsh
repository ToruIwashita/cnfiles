## immediate-git-pull
_immediate-git-pull() {
  local cmd
  cmd="git pull origin $(git symbolic-ref HEAD --short 2>/dev/null)"

  ( ! $(git rev-parse 2>/dev/null) ) && return

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-git-pull _immediate-git-pull
