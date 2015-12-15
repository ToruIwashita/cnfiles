## rails test関連の補完
__word-of-current() {
  compadd 'current'
}

_brspec() {
  _arguments : \
    '(:)-f[File path]:Input spec file path' \
    '(:)-t[Tag]:Input spec tag word:__word-of-current'
}

_brspec-all() {
  _arguments : \
    '(:)-t[Tag]:Input spec tag word:__word-of-current'
}

compdef _brspec brspec
compdef _brspec-all brspec-all
