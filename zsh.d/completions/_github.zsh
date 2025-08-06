## github
__github-pr-numbers() {
  local -a prs pr_numbers pr_descriptions

  prs=(${(f)"$(gh pr list --limit 100 --json number,title -q '.[] | "\(.number) \(.title)"' 2>/dev/null)"})

  if (( ! $#prs )); then
    return 1
  fi

  for pr in $prs; do
    pr_numbers+=(${pr%% *})
    pr_descriptions+=("${pr%% *} - [Pull Request] ${pr#* }")
  done

  compadd -l -V pr-numbers -d pr_descriptions -a pr_numbers
}

__github-issue-numbers() {
  local -a issues issue_numbers issue_descriptions

  issues=(${(f)"$(gh issue list --limit 100 --json number,title -q '.[] | "\(.number) \(.title)"' 2>/dev/null)"})

  if (( ! $#issues )); then
    return 1
  fi

  for issue in $issues; do
    issue_numbers+=(${issue%% *})
    issue_descriptions+=("${issue%% *} - [Issue] ${issue#* }")
  done

  compadd -l -V issue-numbers -d issue_descriptions -a issue_numbers
}

_gpr() {
  _arguments \
    '(-c --comment)'{-c,--comment}'[Show PR comments]' \
    '(-d --diff)'{-d,--diff}'[Show PR diff]' \
    '(-r --review-comment)'{-r,--review-comment}'[Show PR review comments]' \
    '(-i --ignore-outdated)'{-i,--ignore-outdated}'[Ignore outdated review comments]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '1: :__github-pr-numbers'
}

_gis() {
  _arguments \
    '(-c --comment)'{-c,--comment}'[Show issue comments]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '1: :__github-issue-numbers'
}

compdef _gpr gpr
compdef _gis gis
