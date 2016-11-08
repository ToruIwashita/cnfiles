## trello関連関数
trello() {
  case "$1" in
    lists)
      trello-lists
      ;;
    *)
      echo "Usage: $0 <lists|list>"
      return 1
      ;;
  esac
}

trello-lists() {
  __trello-lists | jq
}
