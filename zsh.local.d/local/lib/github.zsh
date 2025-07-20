## github
__gh_get_owner_repo() {
  if [[ "$1" =~ ^https://github\.com/([^/]+)/([^/]+)/pull/([0-9]+)(/.*)?/?$ ]]; then
    print "${match[1]}/${match[2]}"
  elif [[ "$1" =~ ^https://github\.com/([^/]+)/([^/]+)/issues/([0-9]+)(/.*)?/?$ ]]; then
    print "${match[1]}/${match[2]}"
  else
    print
  fi
}

__gh_get_number() {
  if [[ "$1" =~ ^https://github\.com/([^/]+)/([^/]+)/pull/([0-9]+)(/.*)?/?$ ]]; then
    print "${match[3]}"
  elif [[ "$1" =~ ^https://github\.com/([^/]+)/([^/]+)/issues/([0-9]+)(/.*)?/?$ ]]; then
    print "${match[3]}"
  else
    print
  fi
}

__gh_is_pull_url() {
  [[ "$1" =~ ^https://github\.com/([^/]+)/([^/]+)/pull/([0-9]+)(/.*)?/?$ ]]
}

__gh_is_issue_url() {
  [[ "$1" =~ ^https://github\.com/([^/]+)/([^/]+)/issues/([0-9]+)(/.*)?/?$ ]]
}
