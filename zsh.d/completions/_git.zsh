## git関数用補完
__git-modified-files() {
  local changes_not_staged_str_index
  local -a git_status_res

  git_status_res=(${(@f)"$(git status -s)"})

  compadd ${(R)${(M)git_status_res:#[[:space:]]M*}#*M[[:space:]]}
}

__git-untracked-files() {
  local untracked_str_index
  local -a git_status_res

  git_status_res=(${(@f)"$(git status -s)"})

  compadd ${(R)${(M)git_status_res:#\?\?*}#\?\?[[:space:]]}
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
compdef _gd gd
compdef _gsw gsw
compdef _gud gud
compdef _gdeleteb gdeleteb
