## git
__git-ref-head() {
  local ref
  ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 1
  print $ref
}

__git-status() {
  __git-inside-work-tree || return
  print "$(git status --short --porcelain)"
}

__git-branch-list() {
  __git-inside-work-tree || return
  local branches
  branches=(${${${(f)"$(git branch)"}:#\* \(HEAD*}#??})
  printf '%s\n' "${branches[@]}"
}

__git-remote-branch-list() {
  __git-inside-work-tree || return
  local -a existing_branches remote_branches

  existing_branches=(${(f)"$(__git-branch-list)"})
  remote_branches=(${${${${(f)"$(git branch --remote)"}:#*->*}#[[:space:]]*origin/}:|existing_branches})

  printf '%s\n' "${remote_branches[@]}"
}

__git-changed-list() {
  __git-inside-work-tree || return
  print $(git diff --name-only origin/HEAD...HEAD)
}

__git-modified-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  print ${(R)${(M)${(@f)"$(__git-status)"}:#?M*}#?M[[:space:]]}
}

__git-untracked-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  print ${(R)${(M)${(@f)"$(__git-status)"}:#\?\?*}#\?\?[[:space:]]}
}

__git-staged-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  print ${(R)${(M)${(@f)"$(__git-status)"}:#M?*}#M?[[:space:]]}
}

__git-both-modified-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  print ${(R)${(M)${(@f)"$(__git-status)"}:#UU*}#UU[[:space:]]}
}

__git-deleted-list() {
  __git-inside-work-tree || return
  local -a git_status_res

  print ${(R)${(M)${(@f)"$(__git-status)"}:#?D*}#?D[[:space:]]}
}

__git-commit-list() {
  __git-inside-work-tree || return
  local commit_format
  commit_format='%h - [%ad] %s @%an'
  git log --pretty=format:"$commit_format" --date=format:'%Y-%m-%d %H:%M' -n 30
}

__git-inside-work-tree() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]
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

  (git add $* 2>/dev/null || git add $(git rev-parse --show-toplevel)/$^*)
}
