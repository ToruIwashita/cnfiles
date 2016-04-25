## git関連関数
__git-ref-head() {
  local ref
  ref=$(git symbolic-ref HEAD --short 2>/dev/null) || return 1
  print $ref
}

__git-status() {
  __git-inside-work-tree || return
  print "$(git status --short --porcelain)"
}

__git-branch-list() {
  __git-inside-work-tree || return
  print ${(R)$(git branch)#\*}
}

__git-remote-branch-list() {
  __git-inside-work-tree || return
  typeset -A existing_branches
  local -a remote_branches
  local existing_branch branch

  for existing_branch in $(__git-branch-list); do
    existing_branches[$existing_branch]='defined'
  done

  for branch in ${${${(f)"$(git branch --remote)"}:#*->*}#[[:space:]]*origin/}; do
    (( ! $+existing_branches[$branch] )) && remote_branches=($remote_branches $branch)
  done

  print $remote_branches
}

__git-changed-list() {
  __git-inside-work-tree || return
  print $(git diff --name-only origin/HEAD...HEAD)
}

__git-modified-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#?M*}#?M[[:space:]]}
}

__git-untracked-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#\?\?*}#\?\?[[:space:]]}
}

__git-staged-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#M?*}#M?[[:space:]]}
}

__git-both-modified-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#UU*}#UU[[:space:]]}
}

__git-inside-work-tree() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true  ]]
}

__ga() {
  local usage

  usage="usage: $0 <files>"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git add $*
}
