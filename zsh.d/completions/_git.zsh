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
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-modified-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

_gau() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-untracked-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

_grh() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-staged-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

_gab() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-both-modified-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

_gd() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-modified-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

_gsw() {
  if [[ -d ./.git ]]; then
    _arguments : '(:)*:argument:__git-branches'
  fi
}

_gud() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-modified-files'
  fi
}

_gdeleteb() {
  if [[ -d ./.git ]]; then
    _arguments : '(:)*:argument:__git-branches'
  fi
}

compdef _gam gam
compdef _gau gau
compdef _grh grh
compdef _gab gab
compdef _gd gd
compdef _gsw gsw
compdef _gud gud
compdef _gdeleteb gdeleteb
