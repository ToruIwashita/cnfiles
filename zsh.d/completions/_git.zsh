## git関数用補完
__git-status() {
  print "$(git status --short --porcelain)"
}

__git-branch-list() {
  print ${(R)$(git branch)#\*}
}

__git-remote-branch-list() {
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
  print "$(git diff --name-only origin/HEAD...HEAD)"
}

__git-modified-list() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#?M*}#?M[[:space:]]}
}

__git-untracked-list() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#\?\?*}#\?\?[[:space:]]}
}

__git-staged-list() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  print ${(R)${(M)git_status_res:#M?*}#M?[[:space:]]}
}

__git-both-modified-list() {
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
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-modified-files'
  else
    _arguments '*: :_files'
  fi
}

_gau() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-untracked-files'
  else
    _arguments '*: :_files'
  fi
}

_gab() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-both-modified-files'
  else
    _arguments '*: :_files'
  fi
}

_grh() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-staged-files'
  else
    _arguments '*: :_files'
  fi
}

_gc() {
  if $(git rev-parse 2>/dev/null); then
    _arguments \
      '(-t --temporary)'{-i,--immediate}'[Temporary commit]' \
      '(-h --help)'{-h,--help}'[Show this help text]'
  fi
}

_gd() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-modified-files'
  else
    _arguments '*: :_files'
  fi
}

_gsw() {
  if $(git rev-parse 2>/dev/null); then
    _arguments \
      '(-r --remote-branch)'{-r,--remote-branch}'[Switch remote branch]: :__git-remote-branches' \
      '(-h --help)'{-h,--help}'[Show this help text]' \
      '(:)*: :__git-branches'
  fi
}

_gud() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-modified-files'
  fi
}

_gll() {
  if $(git rev-parse 2>/dev/null); then
    _arguments \
      '(-b --rebase)'{-b,--rebase}'[Pull rebase]: :__git-branches' \
      '(-h --help)'{-h,--help}'[Show this help text]'
  fi
}

_gsh() {
  if $(git rev-parse 2>/dev/null); then
    _arguments \
      '(-f --force)'{-f,--force}'[Force push]' \
      '(-h --help)'{-h,--help}'[Show this help text]'
  fi
}

_gdeleteb() {
  if $(git rev-parse 2>/dev/null); then
    _arguments \
      '(-f --force)'{-f,--force}'[Force delete merged branches]' \
      '(-h --help)'{-h,--help}'[Show this help text]'
  fi
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
