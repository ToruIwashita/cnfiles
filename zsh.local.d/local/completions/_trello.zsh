## trello関連補完
__trello-list-names() {
  compadd $(__trello-list-name-list)
}

_trello() {
  local state

  _arguments \
    '1: :->service' \
    '2: :->task'

  case "$state" in
    service)
      _arguments \
        '1: :(lists list)'
      ;;
    *)
      case $words[2] in
        list)
          _arguments \
            '*: :__trello-list-names'
          ;;
        *)
      esac
  esac
}

compdef _trello trello
