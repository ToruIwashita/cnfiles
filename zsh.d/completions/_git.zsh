## git関数用補完
__git-status() {
  local git_status
  git_status=$(git status -s) || return
  print $git_status
}

__git-branch-list() {
  print ${(R)$(git branch)#\*}
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

__git-staged-files() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  compadd ${(R)${(M)git_status_res:#M?*}#M?[[:space:]]}
}

__git-both-modified-files() {
  local -a git_status_res

  git_status_res=(${(@f)"$(__git-status)"})
  compadd ${(R)${(M)git_status_res:#UU*}#UU[[:space:]]}
}

__git-branches() {
  compadd $(__git-branch-list)
}

__git-remote-branches() {
  typeset -A existing_branches
  local -a remote_branches
  local existing_branch branch

  for existing_branch in $(__git-branch-list); do
    existing_branches[$existing_branch]='defined'
  done

  for branch in ${${${(f)"$(git branch --remote)"}:#*->*}#[[:space:]]*origin/}; do
    (( ! $+existing_branches[$branch] )) && remote_branches=($remote_branches $branch)
  done

  compadd $remote_branches
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
