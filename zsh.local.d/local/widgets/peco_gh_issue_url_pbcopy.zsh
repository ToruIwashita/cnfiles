## peco-gh-issue-url-pbcopy
_peco-gh-issue-url-pbcopy() {
  local cmd selected_issue issue_number

  selected_issue=$(gh issue list --limit 300 --json number,title,author | jq -r '.[] | "\(.number) - [Issue] \(.title) @\(.author.login)"' | peco --select-1 2>/dev/null)

  if (( ! $#selected_issue )); then
    zle beginning-of-line
    return
  fi

  issue_number=$(echo "$selected_issue" | sed 's/^\([0-9]*\).*/\1/')

  cmd="gh issue view $issue_number --json url -q .url | tr -d '\n' | pbcopy"

  zle -I
  print -s $cmd && eval $cmd
  print "copied to clipboard: $(pbpaste)"
}

zle -N peco-gh-issue-url-pbcopy _peco-gh-issue-url-pbcopy
