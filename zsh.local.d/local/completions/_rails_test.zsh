## rails test関連の補完
__git-status() {
  local git_status
  git_status=$(git status -s) || return
  echo $git_status
}

__git-modified-files() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  compadd ${(R)${(M)git_status_res:#?M*}#?M[[:space:]]}
}


__git-untracked-files() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  compadd ${(R)${(M)git_status_res:#\?\?*}#\?\?[[:space:]]}
}

__word-of-current() {
  compadd 'current'
}

_brspec() {
  _arguments \
    '(-m --modified-file)'{-m,--modified-file}'[With modified file completion]: :__git-modified-files' \
    '(-u --untracked-file)'{-u,--untracked-file}'[With untraced file completion]: :__git-untracked-files' \
    '(-t --tag)'{-t,--tag}'[Tag name]: :__word-of-current' \
    '(-h --help)'{-h,--help}'[Show this help text]' \
    '*: :_files'
}

compdef _brspec brspec
