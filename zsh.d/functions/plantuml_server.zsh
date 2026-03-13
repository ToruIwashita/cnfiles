## plantuml-server
plantuml-server-up() {
  docker compose -f "$CNFILES_DIR_PATH/docker/plantuml-server/docker-compose.yml" up -d
}

plantuml-server-down() {
  docker compose -f "$CNFILES_DIR_PATH/docker/plantuml-server/docker-compose.yml" down
}

plantuml-server-status() {
  docker compose -f "$CNFILES_DIR_PATH/docker/plantuml-server/docker-compose.yml" ps
}
