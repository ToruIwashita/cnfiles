## slack
upload-file-to-slack() {
  local channel file title filename length resp_url resp_complete upload_url file_id

  if (( $# < 2 )); then
    print 'upload-file-to-slack: usage: upload-file-to-slack <channel_id> <file_path> [title]' 1>&2
    return 1
  fi

  channel=$1
  file=$2
  title=${3:-${file:t}}

  if [[ ! -f $file ]]; then
    print "upload-file-to-slack: file not found: $file" 1>&2
    return 1
  fi

  if (( ! $#SLACK_BOT_OAUTH_TOKEN )); then
    print 'upload-file-to-slack: SLACK_BOT_OAUTH_TOKEN is not set' 1>&2
    return 1
  fi

  if (( ! $#channel )); then
    print 'upload-file-to-slack: channel id is required' 1>&2
    return 1
  fi

  if (( ! $+commands[jq] )); then
    print 'upload-file-to-slack: jq is required' 1>&2
    return 1
  fi

  filename=${file:t}
  length=$(wc -c < $file | tr -d '[:space:]')

  # 1) アップロードURLと file_id を取得
  resp_url=$(curl -sS -G 'https://slack.com/api/files.getUploadURLExternal' \
    -H "Authorization: Bearer $SLACK_BOT_OAUTH_TOKEN" \
    --data-urlencode "filename=$filename" \
    --data-urlencode "length=$length")

  if [[ $(print -r -- $resp_url | jq -r '.ok') != true ]]; then
    print "upload-file-to-slack: getUploadURLExternal failed: $(print -r -- $resp_url | jq -r '.error //
.')" 1>&2
    return 1
  fi

  upload_url=$(print -r -- $resp_url | jq -r '.upload_url')
  file_id=$(print -r -- $resp_url | jq -r '.file_id')

  # 2) ファイル本体をアップロードURLへ POST
  if ! curl -sS -f -X POST $upload_url -F "file=@$file" >/dev/null; then
    print 'upload-file-to-slack: file upload failed' 1>&2
    return 1
  fi

  # 3) アップロード完了 + チャンネルへ共有
  resp_complete=$(curl -sS -X POST 'https://slack.com/api/files.completeUploadExternal' \
    -H "Authorization: Bearer $SLACK_BOT_OAUTH_TOKEN" \
    --data-urlencode "files=[{\"id\":\"$file_id\",\"title\":\"$title\"}]" \
    --data-urlencode "channel_id=$channel")

  if [[ $(print -r -- $resp_complete | jq -r '.ok') != true ]]; then
    print "upload-file-to-slack: completeUploadExternal failed: $(print -r -- $resp_complete | jq -r
'.error // .')" 1>&2
    return 1
  fi

  print "upload-file-to-slack: uploaded (file_id=$file_id channel=$channel title=$title)"
}
