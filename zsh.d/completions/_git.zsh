## git関数用補完
function __git-modified-files() {
  local git_status_res changes_not_staged_str_index

  git_status_res="$(git status)"
  changes_not_staged_str_index=$((${${(f@)git_status_res}[(i)*Changes not staged*]} + 4))

  compadd ${(R)${(M)${${(f@)git_status_res}[$changes_not_staged_str_index,-1]}:#*modified:*}##*: #}
}

function __git-untracked-files() {
  local git_status_res untracked_str_index

  git_status_res="$(git status)"
  untracked_str_index=$((${${(f@)git_status_res}[(i)*Untracked*]} + 3))

  compadd ${(R)${(M)${${(f@)git_status_res}[$untracked_str_index,-1]}##\#*}#\#[[:blank:]]}
}

function __git-branches() {
  compadd ${(R)$(git branch)#\*}
}

function _gam() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-modified-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

function _gau() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-untracked-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

function _gd() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-modified-files'
  else
    _arguments : '(-)*:argument:_files'
  fi
}

function _gsw() {
  if [[ -d ./.git ]]; then
    _arguments : '(:)*:argument:__git-branches'
  fi
}

function _gud() {
  if [[ -d ./.git ]]; then
    _arguments : '(-)*:argument:__git-modified-files'
  fi
}

function _gdeleteb() {
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
