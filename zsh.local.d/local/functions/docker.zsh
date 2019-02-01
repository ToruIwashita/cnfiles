watch-docker-ps() {
  watch -c 'docker ps'
}

docker-container-login() {
  local container_id container_name peco_resulting_line

  peco_resulting_line=(${(f)"$(docker container ls | tail -n +2 | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_line )); then
    return
  fi

  container_id=${peco_resulting_line%% *}
  container_name=${peco_resulting_line##* }

  print "Login container: $container_name"
  echo

  docker exec -it $container_id sh
}
