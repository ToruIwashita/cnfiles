## rspec
__word-of-current() {
  compadd 'current'
}

# _git.zshの補完使用
__git-changed-spec-files() {
  compadd ${(M)$(__git-changed-list)#*_spec.rb}
}

__git-modified-spec-files() {
  compadd ${(M)$(__git-modified-list)#*_spec.rb}
}

__git-untracked-spec-files() {
  compadd ${(M)$(__git-untracked-list)#*_spec.rb}
}

_brspec() {
  _arguments \
    '(-c --changed-file)'{-c,--changed-file}'[With changed file completion]: :__git-changed-spec-files' \
    '(-e --example)'{-e,--example}'[Filter test by string]: :_nothing' \
    '(-f --fail-fast)'{-f,--fail-fast}'[Fail fast]: :_nothing' \
    '(-m --modified-file)'{-m,--modified-file}'[With modified file completion]: :__git-modified-spec-files' \
    '(-n --no-binstub)'{-n,--no-binstub}'[Do not use binstub]' \
    '(-s --seed)'{-s,--seed}'[Specify the seed value]: :_nothing' \
    '(-t --tag)'{-t,--tag}'[Tag name]: :__word-of-current' \
    '(-u --untracked-file)'{-u,--untracked-file}'[With untraced file completion]: :__git-untracked-spec-files' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '*: :_files'
}

compdef _brspec brspec
