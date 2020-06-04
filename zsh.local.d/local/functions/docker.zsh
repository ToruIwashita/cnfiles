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
