## git
gchanged-files() {
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  __git-changed-list | tr ' ' '\n'
}

gbranch-default() {
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  __git-default-branch
}

ga() {
  integer unstage
  local self_cmd help usage
  local -a file_paths

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [files]
              [-u --unstage]
              [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -u | --unstage)
        (( unstage++ ))
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift
        file_paths+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        file_paths+=("$1")
        shift 1
        ;;
    esac
  done

  if (( unstage )); then
    if (( ${#file_paths} )); then
      git restore --staged $(git rev-parse --show-toplevel)/"${^file_paths[@]}"
    else
      git restore --staged "$(git rev-parse --show-toplevel)" &>/dev/null
    fi

    git status --short

    return 0
  fi

  if (( ${#file_paths} )); then
    git add $(git rev-parse --show-toplevel)/"${^file_paths[@]}"
  else
    git add "$(git rev-parse --show-toplevel)"
  fi

  git status --short
}

gam() {
  local usage

  usage="usage: $0 <files>"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  (git diff $(git rev-parse --show-toplevel)/$^*) &&
    (git add $(git rev-parse --show-toplevel)/$^*)
}

gau() {
  __ga $*
}

gac() {
  __ga $*
}

gab() {
  __ga $*
}

gad() {
  __ga $*
}

gclean-m() {
  local answer

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  git ls-files --modified && echo

  while :; do
    print -n 'Clean above files (y/n)? '

    read answer
    case "$answer" in
      [yY])
        git checkout .
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
}

gclean-u() {
  local answer

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  git ls-files --exclude-standard --others && echo

  while :; do
    print -n 'Clean above files (y/n)? '

    read answer
    case "$answer" in
      [yY])
        git clean -d -f &>/dev/null
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
}

gclean() {
  local answer

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  git status --short && echo

  while :; do
    print -n 'Clean above files (y/n)? '

    read answer
    case "$answer" in
      [yY])
        git checkout . && git clean -d -f &>/dev/null
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
}

greset-all() {
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  git reset &>/dev/null
  git status --short
}

grecover-latest-remote() {
  local answer current_branch

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  current_branch=$(__git-ref-head)

  while :; do
    print -n "Recover latest of remote '$current_branch' branch (y/n)? "

    read answer
    case "$answer" in
      [yY])
        git fetch
        git reset --hard origin/$current_branch
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
}

greset-hard-latest() {
  local answer

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  while :; do
    print -n "Reset hard latest '$(git log --pretty=format:'[%h]%s' --max-count=1)' commit (y/n)? "

    read answer
    case "$answer" in
      [yY])
        git reset --hard HEAD^
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
}

greset-mixed-latest() {
  local answer

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  while :; do
    print -n "Reset mixed latest '$(git log --pretty=format:'[%h]%s' --max-count=1)' commit (y/n)? "

    read answer
    case "$answer" in
      [yY])
        git reset --mixed HEAD^
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
}

greset-soft-latest() {
  local answer

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    return 1
  fi

  while :; do
    print -n "Reset soft latest '$(git log --pretty=format:'[%h]%s' --max-count=1)' commit (y/n)? "

    read answer
    case "$answer" in
      [yY])
        git reset --soft HEAD^
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
}

gc() {
  integer empty fixup temporary
  local self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-e --empty]
          [-f --fixup]
          [-t --temporary]
          [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -e | --empty)
        (( empty++ ))
        shift 1
        ;;
      -f | --fixup)
        (( fixup++ ))
        shift 1
        ;;
      -t | --temporary)
        (( temporary++ ))
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
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  if (( temporary )); then
    git commit -m "[temporary commit]($(__git-ref-head)) $(LANG=C date)"
    return 0
  fi

  if (( empty )); then
    git commit --allow-empty -m "[empty commit]($(__git-ref-head)) $(LANG=C date)"
    return 0
  fi

  if (( fixup )); then
    git commit --amend --no-edit --allow-empty
    return 0
  fi

  git commit
}

gd() {
  integer id_only
  local self_cmd help usage name_only_option staged_option commit_option
  local -a file_paths

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [files]
          [-i --id-only]
          [-l --log [commit_id]]
          [-n --name-only]
          [-s --staged]
          [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -l | --log)
        if (( $#2 )) && [[ "$2" != -* ]]; then
          commit_option="$2"
          shift 2
        else
          commit_option="origin/HEAD...HEAD"
          shift 1
        fi
        ;;
      -i | --id-only)
        (( id_only++ ))
        shift 1
        ;;
      -n | --name-only)
        name_only_option=" --name-only"
        shift 1
        ;;
      -s | --staged)
        staged_option=" --staged"
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift
        file_paths+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        file_paths+=("$1")
        shift 1
        ;;
    esac
  done

  # -iオプションの処理
  if (( id_only )); then
    if (( $#commit_option )) && [[ "$commit_option" != "origin/HEAD...HEAD" ]]; then
      git rev-parse --short "$commit_option"
    fi
    return 0
  fi

  if (( $#commit_option )); then
    # -lのみの場合
    if [[ "$commit_option" == "origin/HEAD...HEAD" ]]; then
      [[ -t 1 ]] && print "\033[36mgit diff${name_only_option} $commit_option\033[0m\n"
      git diff ${(z)name_only_option} "$commit_option"
      return 0
    fi

    # -l $commit_idの場合
    [[ -t 1 ]] && print "\033[36mgit diff${name_only_option} $commit_option^..$commit_option\033[0m\n"
    git diff ${(z)name_only_option} "$commit_option"^.."$commit_option"
    return 0
  fi

  if (( ${#file_paths} )); then
    [[ -t 1 ]] && print "\033[36mgit diff${staged_option}${name_only_option} ${file_paths[*]}\033[0m\n"
    (git diff ${(z)staged_option} ${(z)name_only_option} "${file_paths[@]}" 2>/dev/null || git diff ${(z)staged_option} ${(z)name_only_option} $(git rev-parse --show-toplevel)/"${^file_paths[@]}")
    return 0
  fi

  [[ -t 1 ]] && print "\033[36mgit diff${staged_option}${name_only_option}\033[0m\n"
  git diff ${(z)staged_option} ${(z)name_only_option}
}

gsw() {
  integer branch_already_exists
  local branch remote_branch self_cmd help usage
  local -a args

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
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        remote_branch="$2"
        shift 2
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift;
        args+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        args+=("$1")
        shift 1
        ;;
    esac
  done

  if ! __git-inside-work-tree; then
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

  if (( ! branch_already_exists )); then
    if (( $#remote_branch )); then
      print 'Fetching remote'
      git fetch --prune && git branch $branch origin/$branch
    else
      git branch $branch
    fi
  fi

  git checkout $branch
}

gud() {
  local usage

  usage="usage: $0 <files>"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  if (( ! $# )); then
    print $usage 1>&2
    return 1
  fi

  (git checkout $* 2>/dev/null || git checkout $(git rev-parse --show-toplevel)/$^*)
}

gll() {
  local self_cmd help usage current_branch base_branch answer

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-b --rebase <base branch>]
           [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -b | --rebase)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
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
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
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
    print "Pull '$current_branch' branch"
    git pull origin $current_branch
  else
    while :; do
      print -n "Rebase '$current_branch' onto '$base_branch' (y/n)? "

      read answer
      case "$answer" in
        [yY])
          print 'Fetch & rebase'
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

gll-tags() {
  local usage

  usage="usage: $0"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  print "Pull all tags\n"
  git pull origin --tags
}

glls() {
  local usage
  local remote_head_branch

  usage="usage: $0"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  remote_head_branch=${(R)$(git symbolic-ref --short refs/remotes/origin/HEAD)#*/}

  print "Submodules update & pull $remote_head_branch\n"
  git submodule foreach "
    git checkout ${(R)${(M)${(@f)"$(git remote show origin)"}:#[[:space:]][[:space:]]HEAD[[:space:]]branch:*}#[[:space:]][[:space:]]HEAD[[:space:]]branch:[[:space:]]}
    git pull origin ${(R)${(M)${(@f)"$(git remote show origin)"}:#[[:space:]][[:space:]]HEAD[[:space:]]branch:*}#[[:space:]][[:space:]]HEAD[[:space:]]branch:[[:space:]]}
    echo
  "
}

gsh() {
  integer force
  local self_cmd help usage current_branch answer

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force-with-lease]
           [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -f | --force-with-lease)
        (( force++ ))
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
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  current_branch=$(__git-ref-head)

  print "Push '$current_branch' branch"

  if (( force )); then
    while :; do
      print -n "Force push with lease (y/n)? "
      read answer
      case "$answer" in
        [yY])
          git push --force-with-lease origin $current_branch
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

gsh-tags() {
  local usage

  usage="usage: $0"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while :; do
    print -n "Push all tags (y/n)? "

    read answer
    case "$answer" in
      [yY])
        git push origin --tags
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
}

grebase() {
  local usage current_branch rebase_target

  usage="usage: $0 <number for rebase target>"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  current_branch=$(__git-ref-head)

  if (( ! $# )); then
    rebase_target='origin/HEAD'
  else
    rebase_target="HEAD~$1"
  fi

  while :; do
    print -n "Rebase '$current_branch' onto '$rebase_target' (y/n)? "
    read answer
    case "$answer" in
      [yY])
        git rebase -i $rebase_target
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
}

grebase-ignore-date() {
  local usage current_branch rebase_target

  usage="usage: $0 <number for rebase target>"
  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  current_branch=$(__git-ref-head)

  if (( ! $# )); then
    rebase_target='origin/HEAD'
  else
    rebase_target="HEAD~$1"
  fi

  while :; do
    print -n "Rebase ignoring dates '$current_branch' onto '$rebase_target' (y/n)? "
    read answer
    case "$answer" in
      [yY])
        git rebase --ignore-date $rebase_target
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
}

gpickfile() {
  local self_cmd help usage file_name branch_name
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <file name>
             <-b --branch <branch name>>
             [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -b | --branch)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        branch_name="$2"
        shift 2
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift;
        args+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        args+=("$1")
        shift 1
        ;;
    esac
  done


  file_name=${args[1]}
  if (( ! ${#args} || ! $#branch_name )); then
    print "$self_cmd: requires arguments\n$help" 1>&2
    return 1
  fi

  git checkout $branch_name -- $file_name
}

gdeleteb() {
  integer all
  local self_cmd help usage merged_branch answer
  local -a merged_branches

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-a --all]
                [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -a | --all)
        (( all++ ))
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
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  git fetch --prune
  merged_branches=(${(R)${(R)${(@f)"$(git branch --merged)"}:#\*[[:space:]]*}##*[[:space:]]})

  if (( all )); then
    while :; do
      print -n "Delete all merged branches (y/n)? "

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

gl() {
  integer graph
  local self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-g --graph]
                [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -g | --graph)
        (( graph++ ))
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
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  if (( graph )); then
    git log --graph --date-order -C -M --pretty=format:"<%h> %ad [%an] %Cgreen%d%Creset %s" --all --date=short
  else
    git log --pretty=fuller
  fi
}
