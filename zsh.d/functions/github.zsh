## github
gpr-search() {
  local self_cmd help usage commit_id limit_option
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <commit_id>
           [-l --limit <number>]
           [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -l | --limit)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        limit_option="--limit $2"
        shift 2
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
    print "$self_cmd: commit_id is required\n$help" 1>&2
    return 1
  fi

  commit_id="${args[1]}"

  gh pr list --search "$commit_id" --state merged ${=limit_option} 2>/dev/null
}

gpr() {
  integer show_comment show_review_comment ignore_outdated show_diff pr_count
  local self_cmd help usage current_branch pr_list default_pr_number pr_number owner_repo jq_filter body_content json_comments json_review_comments comment
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <pr number|pr url>
           [-c --comment]
           [-d --diff]
           [-i --ignore-outdated]
           [-r --review-comment]
           [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -c | --comment)
        (( show_comment++ ))
        shift
        ;;
      -d | --diff)
        (( show_diff++ ))
        shift
        ;;
      -i | --ignore-outdated)
        (( ignore_outdated++ ))
        shift
        ;;
      -r | --review-comment)
        (( show_review_comment++ ))
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
    if ! __git-inside-work-tree; then
      print 'Not a git repository: .git'
      print $usage 1>&2
      return 1
    fi

    current_branch=$(git branch --show-current)
    pr_list=$(gh pr list --head "$current_branch" | cat)

    if [[ -z "$pr_list" ]]; then
      print "$self_cmd: No PR found for current branch '$current_branch'"
      print $usage 1>&2
      return 1
    fi

    pr_count=$(echo "$pr_list" | wc -l)

    if (( pr_count > 1 )); then
      print "$self_cmd: Multiple PRs found for current branch '$current_branch', cannot determine which to use"
      print $usage 1>&2
      return 1
    fi

    auto_pr_number=$(echo "$pr_list" | awk '{print $1}')
    args+=("$auto_pr_number")
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

  if (( show_diff )); then
    gh pr diff "$pr_number"
    return
  fi

  if (( show_comment )); then
    [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/issues/$pr_number/comments\"\033[0m\n"

    json_comments=$(gh api "repos/$owner_repo/issues/$pr_number/comments" 2>/dev/null)

    if [[ -z "$json_comments" ]] || [[ "$json_comments" =~ "message.*Not Found" ]]; then
      print 'PR Comments Not Found or No Comments'
    else
      echo -E "$json_comments" | jq -c '.[]' | while read -r comment; do
        echo -E "$comment" | jq '{author: .user.login, created_at: .created_at, updated_at: .updated_at}'

        if [[ -t 1 ]]; then
          print "\n\033[36m=== body (rendered with glow) ===\033[0m"
        else
          print "\n=== body ==="
        fi

        echo -E "$comment" | jq -r '.body // empty' 2>/dev/null | __smart_glow

        if [[ -t 1 ]]; then
          print "\033[36m===\033[0m\n"
        else
          print "===\n"
        fi
      done
    fi
  fi

  if (( show_review_comment )); then
    [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/pulls/$pr_number/comments\"\033[0m\n"

    if (( ignore_outdated )); then
      json_review_comments=$(gh api "repos/$owner_repo/pulls/$pr_number/comments" 2>/dev/null | jq 'map(select(.position != null or .original_position == null))' 2>/dev/null)
    else
      json_review_comments=$(gh api "repos/$owner_repo/pulls/$pr_number/comments" 2>/dev/null)
    fi

    if [[ -z "$json_review_comments" ]] || [[ "$json_review_comments" =~ "message.*Not Found" ]]; then
      print 'PR Review Comments Not Found or No Comments'
    else
      echo -E "$json_review_comments" | jq -c '.[]' | while read -r comment; do
        echo -E "$comment" | jq '{author: .user.login, commit_id: .commit_id, original_commit_id: .original_commit_id, created_at: .created_at, updated_at: .updated_at, path: .path, diff_hunk: .diff_hunk, line: .line, position: .position, side: .side}'

        if [[ -t 1 ]]; then
          print "\n\033[36m=== body (rendered with glow) ===\033[0m"
        else
          print "\n=== body ==="
        fi

        echo -E "$comment" | jq -r '.body // empty' 2>/dev/null | __smart_glow

        if [[ -t 1 ]]; then
          print "\033[36m===\033[0m\n"
        else
          print "===\n"
        fi
      done
    fi
  fi

  if (( show_comment || show_review_comment )); then
    return
  fi

  jq_filter='{number: .number, title: .title, state: .state, author: .user.login, created_at: .created_at, updated_at: .updated_at, closed_at: .closed_at, merged_at: .merged_at, mergeable_state: .mergeable_state, labels: [.labels[].name]}'
  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/pulls/$pr_number\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/pulls/$pr_number" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'PR Not Found')

  body_content=$(gh api "repos/$owner_repo/pulls/$pr_number" 2>/dev/null | jq -r '.body // empty' 2>/dev/null)

  if [[ -t 1 ]]; then
    print "\n\033[36m=== body (rendered with glow) === \033[0m"
  else
    print "\n=== body ==="
  fi

  if [[ -n "$body_content" && "$body_content" != "null" ]]; then
    echo "$body_content" | __smart_glow
  fi
}

gis() {
  integer show_comments
  local self_cmd help usage issue_number owner_repo jq_filter body_content json_comments comment
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <issue number|issue url>
           [-c --comment]
           [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -c | --comment)
        (( show_comments++ ))
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

  if (( show_comments )); then
    [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/issues/$issue_number/comments\"\033[0m\n"

    json_comments=$(gh api "repos/$owner_repo/issues/$issue_number/comments" 2>/dev/null)

    echo -E "$json_comments" | jq -c '.[]' | while read -r comment; do
      echo -E "$comment" | jq '{author: .user.login, created_at: .created_at, updated_at: .updated_at}'

      if [[ -t 1 ]]; then
        print "\n\033[36m=== body (rendered with glow) ===\033[0m"
      else
        print "\n=== body ==="
      fi

      echo -E "$comment" | jq -r '.body // empty' 2>/dev/null | __smart_glow

      if [[ -t 1 ]]; then
        print "\033[36m===\033[0m\n"
      else
        print "===\n"
      fi
    done

    return
  fi

  jq_filter='{number: .number, title: .title, state: .state, author: .user.login, created_at: .created_at, updated_at: .updated_at, closed_at: .closed_at, labels: [.labels[].name]}'
  [[ -t 1 ]] && print "\033[36mgh api \"repos/$owner_repo/issues/$issue_number\" | jq '$jq_filter'\033[0m\n"
  gh api "repos/$owner_repo/issues/$issue_number" 2>/dev/null | (jq "$jq_filter" 2>/dev/null || print 'Issue Not Found')

  body_content=$(gh api "repos/$owner_repo/issues/$issue_number" 2>/dev/null | jq -r '.body // empty' 2>/dev/null)

  if [[ -t 1 ]]; then
    print "\n\033[36m=== body (rendered with glow) ===\033[0m"
  else
    print "\n=== body ==="
  fi

  if [[ -n "$body_content" && "$body_content" != "null" ]]; then
    echo "$body_content" | __smart_glow
  fi
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
