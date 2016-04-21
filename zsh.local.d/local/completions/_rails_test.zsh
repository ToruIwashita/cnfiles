## rails test関連の補完
__word-of-current() {
  compadd 'current'
}

# _git.zshの補完も使用
_brspec() {
  _arguments \
    '(-c --changed-file)'{-c,--changed-file}'[With changed file completion]: :__git-changed-files' \
    '(-m --modified-file)'{-m,--modified-file}'[With modified file completion]: :__git-modified-files' \
    '(-u --untracked-file)'{-u,--untracked-file}'[With untraced file completion]: :__git-untracked-files' \
    '(-t --tag)'{-t,--tag}'[Tag name]: :__word-of-current' \
    '(-h --help)'{-h,--help}'[Show this help text]' \
    '*: :_files'
}

compdef _brspec brspec
