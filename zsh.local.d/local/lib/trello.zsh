## trello関連関数
__trello-lists() {
  curl "https://trello.com/1/boards/$TRELLO_BOARD_ID/lists?key=$TRELLO_API_KEY&token=$TRELLO_API_TOKEN" 2>/dev/null
}

__trello-list-name-list() {
  echo ${(@f)"$(__trello-lists | jq '.[].name')"}
}
