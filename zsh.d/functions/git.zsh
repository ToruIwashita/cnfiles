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

gc() {
  local self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-b --rebase <base branch>]
           [-h --help]
EOF`

  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -t | --temporary)
        temporary=1
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  if (( temporary )); then
    git commit -m "[temporary commit]($(__git-ref-head)) $(date)"
  else
    git commit
  fi
}

gd() {
  local usage

  usage="usage: $0 <file>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  git diff $*
}

gsw() {
  local -a args branch remote_branch branch_already_exists
  local self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <argument info>
          [-r --remote-branch <branch name>]
          [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -r | --remote-branch)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        remote_branch="$2"
        shift 2
        ;;
      --help | -h)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift;
        args+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        args+=("$1")
        shift 1
        ;;
    esac
  done

  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ${#args} )); then
    branch=${args[1]}
  else
    branch=$remote_branch
  fi

  if (( ! $#branch )); then
    print $usage
    return 1
  fi

  branch_already_exists=${#${(M)${(R)$(git branch)#\*}:#$branch}}

  if (( branch_already_exists )); then
    git checkout $branch
  else
    if (( $#remote_branch )); then
      print 'fetching remote'
      git fetch && git branch $branch origin/$branch
    else
      gll
    fi

    echo
    git checkout -b $branch
  fi
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
  local self_cmd help usage current_branch base_branch answer

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-b --rebase <base branch>]
           [-h --help]
EOF`

  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -b | --rebase)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        base_branch="$2"
        shift 2
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  current_branch=$(__git-ref-head)

  if (( ! $#base_branch )); then
    print "pull $current_branch branch"
    git pull origin $current_branch
  else
    while :; do
      print -n "rebase '$current_branch' based on '$base_branch' (y/n)? "

      read answer
      case "$answer" in
        [yY])
          print 'fetch & rebase'
          git pull --rebase origin $base_branch
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
  fi
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
  local self_cmd help usage force current_branch answer

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force]
           [-h --help]
EOF`

  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -f | --force)
        force=1
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
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

grb() {
  local usage

  usage="usage: $0 <number for rebase target>"
  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  print "rebase HEAD~$1"
  git rebase -i HEAD~$1
}

gdeleteb() {
  local -a merged_branches
  local self_cmd help usage merged_branch answer

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force]
                [-h --help]
EOF`

  if ! $(git rev-parse 2>/dev/null); then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -f | --force)
        force=1
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  git fetch && print "Fetched remote\n"
  merged_branches=(${(R)${(R)${(@f)"$(git branch --merged)"}:#\*[[:space:]]*}##*[[:space:]]})

  if (( $force )); then
    while :; do
      print -n "Force delete merged branches (y/n)? "

      read answer
      case "$answer" in
        [yY])
          for merged_branch in $merged_branches; do
            git branch -D $merged_branch
          done
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

    return 0
  fi

  for merged_branch in $merged_branches; do
    while :; do
      print -n "Delete '$merged_branch' branch (y/n)? "

      read answer
      case "$answer" in
        [yY])
          git branch -D $merged_branch && echo
          break
          ;;
        [nN])
          echo && break
          ;;
        *)
          print -n 'Please enter y or n. '
          ;;
      esac
    done
  done
}

__git-ref-head() {
  local ref
  ref=$(git symbolic-ref HEAD --short 2>/dev/null) || return 1
  print $ref
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
