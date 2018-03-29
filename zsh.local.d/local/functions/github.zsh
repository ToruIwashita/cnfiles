github-traffic() {
  local repo

  for repo in $OWNED_GITHUB_REPOSITORIES; do
    print $repo
    print "stars: $(curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$GITHUB_USER_NAME/$repo/stargazers 2> /dev/null | jq -c 'length')"
    print 'views:'
    curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$GITHUB_USER_NAME/$repo/traffic/views 2>/dev/null| jq -c '.views[]'
    print 'clones:'
    curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$GITHUB_USER_NAME/$repo/traffic/clones 2>/dev/null | jq -c '.clones[]'
    echo
  done
}
