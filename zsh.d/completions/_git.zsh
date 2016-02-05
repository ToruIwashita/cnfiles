## git関数用補完
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
  compadd ${(R)$(git branch)#\*}
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

_grh() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-staged-files'
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

_gd() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-modified-files'
  else
    _arguments '*: :_files'
  fi
}

_gsw() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '(:)*: :__git-branches'
  fi
}

_gud() {
  if $(git rev-parse 2>/dev/null); then
    _arguments '*: :__git-modified-files'
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
    _arguments '(:)*: :__git-branches'
  fi
}

compdef _gam gam
compdef _gau gau
compdef _gab gab
compdef _grh grh
compdef _gd gd
compdef _gsw gsw
compdef _gud gud
compdef _gsh gsh
compdef _gdeleteb gdeleteb
