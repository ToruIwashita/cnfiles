## peco-gh-pull-request-url-pbcopy
_peco-gh-pull-request-url-pbcopy() {
  local cmd selected_pr pr_number

  selected_pr=$(gh pr list --limit 300 --json number,title,author | jq -r '.[] | "\(.number) - [Pull Request] \(.title) @\(.author.login)"' | peco --select-1 2>/dev/null)

  if (( ! $#selected_pr )); then
    zle beginning-of-line
    return
  fi

  pr_number=$(echo "$selected_pr" | sed 's/^\([0-9]*\).*/\1/')

  cmd="gh pr view $pr_number --json url -q .url | tr -d '\n' | pbcopy"

  zle -I
  print -s $cmd && eval $cmd
  print "copied to clipboard: $(pbpaste)"
}

zle -N peco-gh-pull-request-url-pbcopy _peco-gh-pull-request-url-pbcopy
