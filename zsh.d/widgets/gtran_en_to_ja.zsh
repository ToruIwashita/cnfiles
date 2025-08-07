## gtran-en-to-ja
_gtran-en-to-ja() {
  BUFFER="gtran '$BUFFER'"
  zle accept-line
}

zle -N gtran-en-to-ja _gtran-en-to-ja
