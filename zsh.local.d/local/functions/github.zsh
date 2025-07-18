## github
gpr() {
  local self_cmd help usage pr_number owner_repo jq_filter
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <pr_number|pr_url>
           [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift
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

  if (( ! ${#args} )); then
    print $usage 1>&2
    return 1
  fi

  if [[ "${args[1]}" =~ ^https://github\.com/([^/]+)/([^/]+)/pull/([0-9]+)(/.*)?/?$ ]]; then
    owner_repo="${match[1]}/${match[2]}"
    pr_number="${match[3]}"
  elif [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}')
    pr_number=${args[1]}
  else
    print "$self_cmd: invalid argument -- '${args[1]}' must be a PR number or GitHub PR URL\n$help" 1>&2
    return 1
  fi

  jq_filter='{number: .number, title: .title, state: .state, author: .user.login, created_at: .created_at, updated_at: .updated_at, labels: [.labels[].name], body: .body}'

  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/pulls/$pr_number\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/pulls/$pr_number" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'PR Not Found')
}

gis() {
  local self_cmd help usage issue_number owner_repo jq_filter
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <issue_number|issue_url>
           [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift
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

  if (( ! ${#args} )); then
    print $usage 1>&2
    return 1
  fi

  if [[ "${args[1]}" =~ ^https://github\.com/([^/]+)/([^/]+)/issues/([0-9]+)(/.*)?/?$ ]]; then
    owner_repo="${match[1]}/${match[2]}"
    issue_number="${match[3]}"
  elif [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}')
    issue_number=${args[1]}
  else
    print "$self_cmd: invalid argument -- '${args[1]}' must be an issue number or GitHub issue URL\n$help" 1>&2
    return 1
  fi

  jq_filter='{number: .number, title: .title, state: .state, author: .user.login, created_at: .created_at, labels: [.labels[].name], body: .body}'

  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/issues/$issue_number\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/issues/$issue_number" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'Issue Not Found')
}

gpr-comments() {
  integer ignore_outdated
  local self_cmd help usage pr_number owner_repo jq_filter
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <pr_number|pr_url>
                    [-i --ignore-outdated]
                    [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -i | --ignore-outdated)
        (( ignore_outdated++ ))
        shift
        ;;
      -- | -) # Stop option processing
        shift
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

  if (( ! ${#args} )); then
    print $usage 1>&2
    return 1
  fi

  if [[ "${args[1]}" =~ ^https://github\.com/([^/]+)/([^/]+)/pull/([0-9]+)(/.*)?/?$ ]]; then
    owner_repo="${match[1]}/${match[2]}"
    pr_number="${match[3]}"
  elif [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}')
    pr_number=${args[1]}
  else
    print "$self_cmd: invalid argument -- '${args[1]}' must be a PR number or GitHub PR URL\n$help" 1>&2
    return 1
  fi

  if (( ignore_outdated )); then
    jq_filter='map(select(.position != null or .original_position == null)) | .[] | {diff_hunk: .diff_hunk, body: .body}'
  else
    jq_filter='.[] | {diff_hunk: .diff_hunk, body: .body}'
  fi

  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/pulls/$pr_number/comments\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/pulls/$pr_number/comments" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'PR Not Found')
}

github-traffic() {
  local repo

  for repo in $OWNED_GITHUB_REPOSITORIES; do
    gh api https://api.github.com/users/$GITHUB_USER_NAME/repos 2>/dev/null | jq 'map(select(.name == "'$repo'")) | map({name, stargazers_count, open_issues_count}) | .[]'
    print "subscribers: $(gh api https://api.github.com/repos/$GITHUB_USER_NAME/$repo 2> /dev/null | jq -c '.subscribers_count')"
    print 'views:'
    gh api https://api.github.com/repos/$GITHUB_USER_NAME/$repo/traffic/views 2>/dev/null | jq -c '.views[]'
    print 'clones:'
    gh api https://api.github.com/repos/$GITHUB_USER_NAME/$repo/traffic/clones 2>/dev/null | jq -c '.clones[]'
    echo
  done
}
