## git関連関数
gam() {
  local usage

  usage="usage: $0 <Files>"
  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git diff $* && git add $*
}

gau() {
  local usage

  usage="usage: $0 <Files>"
  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git add $*
}

gab() {
  local usage

  usage="usage: $0 <Files>"
  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git add $*
}

grh() {
  local usage

  usage="usage: $0 <Files>"
  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git reset HEAD $*
}

gd() {
  local usage

  usage="usage: $0 <File>"
  if [[ $# -gt 1 ]]; then
    print $usage 1>&2
    return 1
  fi

  git diff $*
}

gsw() {
  local usage

  usage="usage: $0 <Branch>"
  if [[ $# -ne 1 ]]; then
    print $usage 1>&2
    return 1
  fi

  git checkout $1 && git branch
}

gud() {
  local usage

  usage="usage: $0 <Files>"
  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git checkout $*
}

gll() {
  local usage current_branch

  usage="usage:<pwd=./.git> $0"
  if [[ ! -d ./.git ]]; then
    print $usage 1>&2
    return 1
  fi

  current_branch=$(_git-ref-head)

  print "pull $current_branch branch"
  git pull origin $current_branch
}

glls() {
  local usage

  usage="usage: $0"
  if [[ ! -d ./.git ]]; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  print "submodules update & pull master\n"
  git submodule update --init
  git submodule foreach "git checkout master && git pull origin master && echo"
}

gsh() {
  local usage force current_branch answer arg

  usage=`cat <<EOF
usage: $0 [-f 'force push']
EOF`

  if [[ ! -d ./.git ]]; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while getopts :f arg; do
    case ${arg} in
      f) force=1 ;;
      \?) print $usage; return 1 ;;
    esac
  done
  shift $((OPTIND-1))

  current_branch=$(_git-ref-head)

  print "push $current_branch branch"

  if (( $force )); then
    while :; do
      print -n "Force push (y/n)? "
      read answer
      case "$answer" in
        [yY]) git push --force origin $current_branch
              break
              ;;
        [nN]) break
              ;;
        *)    print -n 'Please enter y or n. '
              ;;
      esac
    done
  else
    git push origin $current_branch
  fi
}

gcloneb() {
  local usage

  usage="usage: $0 <Branch>"
  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  print "clone origin/$1"
  git branch $1 origin/$1 && gsw $1
}

gdeleteb() {
  local usage

  usage="usage: $0 <Branch>"
  if (( ! $# )); then
    print $usage 1>&2
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
