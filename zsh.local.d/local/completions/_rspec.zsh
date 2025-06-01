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

__git-added-describe-context() {
  local -a spec_files
  local -a examples

  # コマンドラインから既に指定されているspec fileを取得
  spec_files=(${(M)${words[@]}:#*_spec.rb})

  if (( ! $#spec_files )); then
    return 1
  fi

  # 各spec fileのgit diffから追加されたdescribe/contextを抽出
  examples=(${(f)"$(git diff "${spec_files[@]}" 2>/dev/null | \
    grep -E '^\+\s*(describe|context)' | \
    sed -E 's/^.*(describe|context)[[:space:]]+([^[:space:]]+.*[^[:space:]]+)[[:space:]]+do$/\2/')"})

  # 空の要素を除去
  examples=(${examples:#})

  if (( ! $#examples )); then
    return 1
  fi

  # 重複を除去して補完候補として追加
  examples=(${(u)examples[@]})
  compadd -Q -a examples
}

_brspec() {
  _arguments \
    '(-c --changed-file)'{-c,--changed-file}'[With changed file completion]: :__git-changed-spec-files' \
    '(-e --example)'{-e,--example}'[Filter test by string]: :__git-added-describe-context' \
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
