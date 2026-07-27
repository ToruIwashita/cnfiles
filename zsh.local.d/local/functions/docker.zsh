## docker
watch-docker-ps() {
  watch -c 'docker ps'
}

docker-container-login() {
  local container_id login_shell peco_resulting_line

  peco_resulting_line=(${(f)"$(docker container ls | tail -n +2 | awk '{ print $1 "  " $NF }' | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_line )); then
    return
  fi

  container_id=${peco_resulting_line%% *}

  if [[ $(docker exec -it $container_id which bash) ]]; then
    login_shell='bash'
  else
    login_shell='sh'
  fi

  echo

  print "docker exec -it $container_id $login_shell"
  docker exec -it $container_id $login_shell
}

docker-container-attach() {
  local container_id peco_resulting_line

  peco_resulting_line=(${(f)"$(docker container ls | tail -n +2 | awk '{ print $1 "  " $NF }' | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_line )); then
    return
  fi

  container_id=${peco_resulting_line%% *}

  echo

  print "docker attach $container_id"
  docker attach $container_id
}

docker-stop-all() {
  docker stop $(docker ps -q)
}

docker-compose-rebuild() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    print -u2 'not inside a git repository'
    return 1
  fi

  print 'docker compose build --pull --no-cache'
  docker compose build --pull --no-cache || return 1

  print 'docker compose up -d --force-recreate'
  docker compose up -d --force-recreate || return 1

  print 'docker image prune -f'
  docker image prune -f
}

deep-dive-probe-session() {
  local repo_root remote_url

  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    print -u2 'not inside a git repository'
    return 1
  }

  remote_url=$(git config --get remote.origin.url 2>/dev/null)
  if [[ $remote_url != */deep-dive-probe(.git|) ]]; then
    print -u2 'not the deep-dive-probe repository'
    return 1
  fi

  if [[ $PWD != $repo_root ]]; then
    print -u2 "run this from the deep-dive-probe project root (root: $repo_root)"
    return 1
  fi

  if ! docker compose ps --status running --format '{{.Service}}' 2>/dev/null | grep -q '^deep-dive-probe$'; then
    print 'docker compose up -d'
    docker compose up -d || return 1
  fi

  print 'docker compose exec -it deep-dive-probe ./scripts/run-manual.sh'
  docker compose exec -it deep-dive-probe ./scripts/run-manual.sh
}

claude-airlock-session() {
  local repo_root remote_url

  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    print -u2 'not inside a git repository'
    return 1
  }

  remote_url=$(git config --get remote.origin.url 2>/dev/null)
  if [[ $remote_url != */claude-airlock(.git|) ]]; then
    print -u2 'not the claude-airlock repository'
    return 1
  fi

  if [[ $PWD != $repo_root ]]; then
    print -u2 "run this from the claude-airlock project root (root: $repo_root)"
    return 1
  fi

  if ! docker compose ps --status running --format '{{.Service}}' 2>/dev/null | grep -q '^claude-airlock$'; then
    print 'docker compose up -d'
    docker compose up -d || return 1
  fi

  print 'docker compose exec -it claude-airlock /opt/run.sh'
  docker compose exec -it claude-airlock /opt/run.sh
}
