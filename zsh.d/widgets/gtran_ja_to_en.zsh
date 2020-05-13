## gtran_ja_to_en
_gtran-ja-to-en() {
  print -s $BUFFER
  BUFFER="gtran -source 'ja' -target 'en' '$BUFFER'"
  zle accept-line
}

zle -N gtran-ja-to-en _gtran-ja-to-en
