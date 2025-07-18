## github
gpr-comments() {
  local self_cmd help usage pr_number owner_repo
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <pr_number>
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

  pr_number=${args[1]}
  owner_repo=$(gh repo view --json nameWithOwner --template '{{.nameWithOwner}}')
  gh api "repos/$owner_repo/pulls/$pr_number/comments" 2>/dev/null | (jq '.[] | {diff_hunk: .diff_hunk, body: .body}' 2>/dev/null || print 'PR Not Found')
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
