## github
__github-pr-numbers() {
  local -a pr_data pr_numbers pr_descriptions

  pr_data=(${(f)"$(gh pr list --json number,title -q '.[] | "\(.number) \(.title)"' 2>/dev/null)"})

  if (( ! $#pr_data )); then
    return 1
  fi

  for pr in $pr_data; do
    pr_numbers+=(${pr%% *})
    pr_descriptions+=("${pr%% *} - [Pull Request] ${pr#* }")
  done

  compadd -l -V pr-numbers -d pr_descriptions -a pr_numbers
}

__github-issue-numbers() {
  local -a issue_data issue_numbers issue_descriptions

  issue_data=(${(f)"$(gh issue list --json number,title -q '.[] | "\(.number) \(.title)"' 2>/dev/null)"})

  if (( ! $#issue_data )); then
    return 1
  fi

  for issue in $issue_data; do
    issue_numbers+=(${issue%% *})
    issue_descriptions+=("${issue%% *} - [Issue] ${issue#* }")
  done

  compadd -l -V issue-numbers -d issue_descriptions -a issue_numbers
}

_gpr() {
  _arguments \
    '(-c --comment)'{-c,--comment}'[Show PR comments]' \
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
