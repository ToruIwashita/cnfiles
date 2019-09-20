## google_search
_google-search() {
  BUFFER="open https://www.google.co.jp/search?q='$BUFFER'"
  zle accept-line
}

zle -N google-search _google-search
