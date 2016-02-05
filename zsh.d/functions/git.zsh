## git関連関数
gam() {
  local usage

  usage="usage: $0 <files>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git diff $* && git add $*
}

gau() {
  __ga $*
}

gab() {
  __ga $*
}

grh() {
  local usage

  usage="usage: $0 <files>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git reset HEAD $*
}

gd() {
  local usage

  usage="usage: $0 <file>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if [[ $# -gt 1 ]]; then
    print $usage 1>&2
    return 1
  fi

  git diff $*
}

gsw() {
  local usage

  usage="usage: $0 <branch>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if [[ $# -ne 1 ]]; then
    print $usage 1>&2
    return 1
  fi

  git checkout $1 && git branch
}

gud() {
  local usage

  usage="usage: $0 <files>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git checkout $*
}

gll() {
  local usage current_branch

  usage="usage: $0"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  current_branch=$(__git-ref-head)

  print "pull $current_branch branch"
  git pull origin $current_branch
}

glls() {
  local usage

  usage="usage: $0"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  print "submodules update & pull master\n"
  git submodule update --init
  git submodule foreach "git checkout master && git pull origin master && echo"
}

gsh() {
  local -a args
  local self_cmd help usage force current_branch answer

  self_cmd=$(echo "$0" | sed -e 's,.*/,,')
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force 'force push']
           [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      --force | -f)
        force=1
        shift 1
        ;;
      --help | -h)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        break
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: argument unnecessary '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  current_branch=$(__git-ref-head)

  print "push $current_branch branch"

  if (( $force )); then
    while :; do
      print -n "Force push (y/n)? "
      read answer
      case "$answer" in
        [yY])
          git push --force origin $current_branch
          break
          ;;
        [nN])
          break
          ;;
        *)
          print -n 'Please enter y or n. '
          ;;
      esac
    done
  else
    git push origin $current_branch
  fi
}

gcloneb() {
  local usage

  usage="usage: $0 <branch>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  print "clone origin/$1"
  git fetch && git branch $1 origin/$1 && gsw $1
}

gdeleteb() {
  local usage

  usage="usage: $0 <branch>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  print "delete local and origin branch $1"
  git branch -d $1 && git push --delete origin $1
}

__git-ref-head() {
  local ref
  ref=$(git symbolic-ref HEAD --short 2>/dev/null) || return 1
  echo $ref
}

__ga() {
  local usage

  usage="usage: $0 <files>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git add $*
}
