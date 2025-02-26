## github
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
