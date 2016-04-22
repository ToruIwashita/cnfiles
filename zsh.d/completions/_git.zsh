## git関数用補完
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

__git-branches() {
  compadd $(__git-branch-list)
}

__git-remote-branches() {
  compadd $(__git-remote-branch-list)
}

__git-changed-files() {
  compadd $(__git-changed-list)
}

__git-modified-files() {
  compadd $(__git-modified-list)
}

__git-untracked-files() {
  compadd $(__git-untracked-list)
}

__git-staged-files() {
  compadd $(__git-staged-list)
}

__git-both-modified-files() {
  compadd $(__git-both-modified-list)
}

_gam() {
  _arguments '*: :__git-modified-files'
}

_gau() {
  _arguments '*: :__git-untracked-files'
}

_gab() {
  _arguments '*: :__git-both-modified-files'
}

_grh() {
  _arguments '*: :__git-staged-files'
}

_gc() {
  _arguments \
    '(-t --temporary)'{-i,--immediate}'[Temporary commit]' \
    '(-h --help)'{-h,--help}'[Show this help text]'
}

_gd() {
  _arguments '*: :__git-modified-files'
}

_gsw() {
  _arguments \
    '(-r --remote-branch)'{-r,--remote-branch}'[Switch remote branch]: :__git-remote-branches' \
    '(-h --help)'{-h,--help}'[Show this help text]' \
    '(:)*: :__git-branches'
}

_gud() {
  _arguments '*: :__git-modified-files'
}

_gll() {
  _arguments \
    '(-b --rebase)'{-b,--rebase}'[Pull rebase]: :__git-branches' \
    '(-h --help)'{-h,--help}'[Show this help text]'
}

_gsh() {
  _arguments \
    '(-f --force)'{-f,--force}'[Force push]' \
    '(-h --help)'{-h,--help}'[Show this help text]'
}

_gdeleteb() {
  _arguments \
    '(-f --force)'{-f,--force}'[Force delete merged branches]' \
    '(-h --help)'{-h,--help}'[Show this help text]'
}

compdef _gam gam
compdef _gau gau
compdef _gab gab
compdef _grh grh
compdef _gc gc
compdef _gd gd
compdef _gsw gsw
compdef _gud gud
compdef _gll gll
compdef _gsh gsh
compdef _gdeleteb gdeleteb
