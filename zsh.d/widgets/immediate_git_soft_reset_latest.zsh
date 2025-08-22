## immediate-git-soft-reset-latest
_immediate-git-soft-reset-latest() {
  local commit_msg

  zle -I

  if ( ! $(git rev-parse 2>/dev/null) ); then
    return
  fi

  zle push-line

  commit_msg=$(git log --pretty=format:'%h - [%ad] %s @%an%d' --date=format:'%Y-%m-%d %H:%M' --decorate=short --max-count=1)

  if read -q "?Reset soft latest '$commit_msg' commit (y/n)? "; then
    BUFFER='git reset --soft HEAD^ &>/dev/null && git status --short'
    zle accept-line
  else
    zle get-line
  fi

  # 余剰入力の切り捨て（改行制御）
  while read -k 1 -s -t 0; do :; done
}

zle -N immediate-git-soft-reset-latest _immediate-git-soft-reset-latest
