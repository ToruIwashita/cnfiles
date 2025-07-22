## glow
__smart_glow() {
  local input_string
  input_string=$(cat)

  if [[ -z "$input_string" ]]; then
    return
  fi

  if [[ "$input_string" =~ '<[a-zA-Z/][^>]*>' ]]; then
    # 文字列にHTMLタグらしきものが含まれる場合
    (
      echo '```html'
      echo -E "$input_string"
      echo '```'
    ) | glow
  else
    echo -E "$input_string" | glow
  fi
}
