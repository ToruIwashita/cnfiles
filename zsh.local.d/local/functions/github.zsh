## github
gpr() {
  local self_cmd help usage pr_number owner_repo jq_filter body_content
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <pr number|pr url>
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

  if ! __gh_is_pull_url "${args[1]}" && ! [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    print "$self_cmd: invalid argument -- '${args[1]}' must be a PR number or GitHub PR URL\n$help" 1>&2
    return 1
  fi

  if __gh_is_pull_url "${args[1]}"; then
    owner_repo=$(__gh_get_owner_repo "${args[1]}")
    pr_number=$(__gh_get_number "${args[1]}")
  else
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}' 2>/dev/null)
    pr_number="${args[1]}"
  fi

  if [[ -z "$owner_repo" || -z "$pr_number" ]]; then
    print "$self_cmd: failed to parse argument -- '${args[1]}'\n$help" 1>&2
    return 1
  fi

  # 基本情報（bodyを除く）を表示
  jq_filter='{number: .number, title: .title, state: .state, author: .user.login, created_at: .created_at, updated_at: .updated_at, closed_at: .closed_at, merged_at: .merged_at, mergeable_state: .mergeable_state, labels: [.labels[].name]}'
  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/pulls/$pr_number\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/pulls/$pr_number" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'PR Not Found')

  # bodyを取得してglowで表示
  body_content=$(gh api "repos/$owner_repo/pulls/$pr_number" 2>/dev/null | jq -r '.body // empty' 2>/dev/null)
  if [[ -t 1 ]]; then
    print "\n\033[36m=== body (rendered with glow) === \033[0m"
  else
    print "\n=== body ==="
  fi

  if [[ -n "$body_content" && "$body_content" != "null" ]]; then
    echo "$body_content" | glow
  fi
}

gis() {
  local self_cmd help usage issue_number owner_repo jq_filter body_content
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <issue number|issue url>
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

  if ! __gh_is_issue_url "${args[1]}" && ! [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    print "$self_cmd: invalid argument -- '${args[1]}' must be an issue number or GitHub issue URL\n$help" 1>&2
    return 1
  fi

  if __gh_is_issue_url "${args[1]}"; then
    owner_repo=$(__gh_get_owner_repo "${args[1]}")
    issue_number=$(__gh_get_number "${args[1]}")
  else
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}' 2>/dev/null)
    issue_number="${args[1]}"
  fi

  if [[ -z "$owner_repo" || -z "$issue_number" ]]; then
    print "$self_cmd: failed to parse argument -- '${args[1]}'\n$help" 1>&2
    return 1
  fi

  # 基本情報（bodyを除く）を表示
  jq_filter='{number: .number, title: .title, state: .state, author: .user.login, created_at: .created_at, updated_at: .updated_at, closed_at: .closed_at, labels: [.labels[].name]}'
  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/issues/$issue_number\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/issues/$issue_number" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'Issue Not Found')

  # bodyを取得してglowで表示
  body_content=$(gh api "repos/$owner_repo/issues/$issue_number" 2>/dev/null | jq -r '.body // empty' 2>/dev/null)
  if [[ -t 1 ]]; then
    print "\n\033[36m=== body (rendered with glow) ===:\033[0m"
  else
    print "\n=== body ==="
  fi

  if [[ -n "$body_content" && "$body_content" != "null" ]]; then
    echo "$body_content" | glow
  fi
}

gpr-code-comments() {
  integer ignore_outdated
  local self_cmd help usage pr_number owner_repo json_comments comment_body
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <pr number|pr url>
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

  if ! __gh_is_pull_url "${args[1]}" && ! [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    print "$self_cmd: invalid argument -- '${args[1]}' must be a PR number or GitHub PR URL\n$help" 1>&2
    return 1
  fi

  if __gh_is_pull_url "${args[1]}"; then
    owner_repo=$(__gh_get_owner_repo "${args[1]}")
    pr_number=$(__gh_get_number "${args[1]}")
  else
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}' 2>/dev/null)
    pr_number="${args[1]}"
  fi

  if [[ -z "$owner_repo" || -z "$pr_number" ]]; then
    print "$self_cmd: failed to parse argument -- '${args[1]}'\n$help" 1>&2
    return 1
  fi

  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/pulls/$pr_number/comments\"\033[0m\n"

  if (( ignore_outdated )); then
    json_comments=$(gh api "repos/$owner_repo/pulls/$pr_number/comments" 2>/dev/null | jq 'map(select(.position != null or .original_position == null))' 2>/dev/null)
  else
    json_comments=$(gh api "repos/$owner_repo/pulls/$pr_number/comments" 2>/dev/null)
  fi

  if [[ -z "$json_comments" ]] || [[ "$json_comments" =~ "message.*Not Found" ]]; then
    print 'PR Not Found or No Comments'
    return 1
  fi

  # 各コメントを処理
  echo -E "$json_comments" | jq -r '.[] | @base64' | while read -r comment_encoded; do
    comment=$(echo "$comment_encoded" | base64 -d)

    # 基本情報（bodyを除く）を表示
    echo -E "$comment" | jq '{author: .user.login, commit_id: .commit_id, created_at: .created_at, updated_at: .updated_at, diff_hunk: .diff_hunk}'

    # bodyを取得してglowで表示
    comment_body=$(echo -E "$comment" | jq -r '.body // empty' 2>/dev/null)

    if [[ -t 1 ]]; then
      print "\n\033[36m=== body (rendered with glow) ===\033[0m"
    else
      print "\n=== body ==="
    fi

    [[ -n "$comment_body" ]] && echo "$comment_body" | glow

    print -- "---\n"
  done
}

gis-comments() {
  local self_cmd help usage issue_number owner_repo json_comments comment_body
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <issue number|issue url>
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

  if ! __gh_is_issue_url "${args[1]}" && ! [[ "${args[1]}" =~ ^[0-9]+$ ]]; then
    print "$self_cmd: invalid argument -- '${args[1]}' must be an issue number or GitHub issue URL\n$help" 1>&2
    return 1
  fi

  if __gh_is_issue_url "${args[1]}"; then
    owner_repo=$(__gh_get_owner_repo "${args[1]}")
    issue_number=$(__gh_get_number "${args[1]}")
  else
    owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}' 2>/dev/null)
    issue_number="${args[1]}"
  fi

  if [[ -z "$owner_repo" || -z "$issue_number" ]]; then
    print "$self_cmd: failed to parse argument -- '${args[1]}'\n$help" 1>&2
    return 1
  fi

  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/issues/$issue_number/comments\"\033[0m\n"

  # コメントデータを取得
  json_comments=$(gh api "repos/$owner_repo/issues/$issue_number/comments" 2>/dev/null)

  if [[ -z "$json_comments" ]] || [[ "$json_comments" =~ "message.*Not Found" ]]; then
    print 'Issue Comments Not Found or No Comments'
    return 1
  fi

  # 各コメントを処理
  echo -E "$json_comments" | jq -r '.[] | @base64' | while read -r comment_encoded; do
    comment=$(echo "$comment_encoded" | base64 -d)

    # 基本情報（bodyを除く）を表示
    echo -E "$comment" | jq '{author: .user.login, created_at: .created_at, updated_at: .updated_at}'

    # bodyを取得してglowで表示
    comment_body=$(echo -E "$comment" | jq -r '.body // empty' 2>/dev/null)

    if [[ -t 1 ]]; then
      print "\n\033[36m=== body (rendered with glow) ===\033[0m"
    else
      print "\n=== body ==="
    fi

    [[ -n "$comment_body" ]] && print "\n\033[36m=== body (rendered with glow) ===\033[0m"

    print -- "---\n"
  done
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
