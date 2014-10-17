## git関連関数
gam() {
  local gam_usage

  gam_usage="Usage: $0 <Files>"
  if (( ! $# )); then
    print $gam_usage 1>&2
    return 1
  fi

  git diff $* && git add $*
}

gau() {
  local gau_usage

  gau_usage="Usage: $0 <Files>"
  if (( ! $# )); then
    print $gau_usage 1>&2
    return 1
  fi

  git add $*
}

gab() {
  local gab_usage

  gab_usage="Usage: $0 <Files>"
  if (( ! $# )); then
    print $gab_usage 1>&2
    return 1
  fi

  git add $*
}

grh() {
  local grh_usage

  grh_usage="Usage: $0 <Files>"
  if (( ! $# )); then
    print $grh_usage 1>&2
    return 1
  fi

  git reset HEAD $*
}

gd() {
  local gd_usage

  gd_usage="Usage: $0 <File>"
  if [[ $# -gt 1 ]]; then
    print $gd_usage 1>&2
    return 1
  fi

  git diff $*
}

gsw() {
  local gsw_usage

  gsw_usage="Usage: $0 <Branch>"
  if [[ $# -ne 1 ]]; then
    print $gsw_usage 1>&2
    return 1
  fi

  git checkout $1 && git branch
}

gud() {
  local gud_usage

  gud_usage="Usage: $0 <Files>"
  if (( ! $# )); then
    print $gud_usage 1>&2
    return 1
  fi

  git checkout $*
}

gll() {
  local gll_usage current_branch

  gll_usage="Usage:<pwd=./.git> $0"
  if [[ ! -d ./.git ]]; then
    print $gll_usage 1>&2
    return 1
  fi

  current_branch=$(_git-ref-head)

  print "pull $current_branch branch"
  git pull origin $current_branch
}

glls() {
  local glls_usage

  glls_usage="Usage:<pwd=./.git> $0"
  if [[ ! -d ./.git ]]; then
    print $glls_usage 1>&2
    return 1
  fi

  print "submodules update & pull master" && echo
  git submodule update --init
  git submodule foreach 'git checkout master && git pull origin master && echo'
}

gsh() {
  local gsh_usage current_branch

  gsh_usage="Usage:<pwd=./.git> $0"
  if [[ ! -d ./.git ]]; then
    print $gsh_usage 1>&2
    return 1
  fi

  current_branch=$(_git-ref-head)

  print "push $current_branch branch"
  git push origin $current_branch
}

gcloneb() {
  local gcloneb_usage

  gcloneb_usage="Usage: $0 <Branch>"
  if (( ! $# )); then
    print $gcloneb_usage 1>&2
    return 1
  fi

  print "clone origin/$1"
  git branch $1 origin/$1
}

gdeleteb() {
  local gdeleteb_usage

  gdeleteb_usage="Usage: $0 <Branch>"
  if (( ! $# )); then
    print $gdeleteb_usage 1>&2
    return 1
  fi

  print "delete local and origin branch $1"
  git branch -d $1 && git push --delete origin $1
}

_git-ref-head() {
  local ref
  ref=$(git symbolic-ref HEAD --short 2>/dev/null) || return 1
  echo $ref
}
