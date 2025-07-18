## github
__github-pr-numbers() {
  local -a pr_data pr_numbers pr_descriptions

  pr_data=(${(f)"$(gh pr list --json number,title -q '.[] | "\(.number) \(.title)"' 2>/dev/null)"})

  if (( ! $#pr_data )); then
    return 1
  fi

  for pr in $pr_data; do
    pr_numbers+=(${pr%% *})
    pr_descriptions+=($pr)
  done

  compadd -V pr-numbers -d pr_descriptions -a pr_numbers
}

_gpr-comments() {
  _arguments \
    '(-i --ignore-outdated)'{-i,--ignore-outdated}'[Ignore outdated comments]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '1: :__github-pr-numbers'
}

compdef _gpr-comments gpr-comments
