## rails test関連の補完
__add-current-of-word() {
  compadd 'current'
}

_brspec() {
  _arguments : \
    '(:)-f[File path]:Input spec file path' \
    '(:)-t[Tag]:Input spec tag word:__add-current-of-word'
}

_brspec_all() {
  _arguments : \
    '(:)-t[Tag]:Input spec tag word:__add-current-of-word'
}

compdef _brspec brspec
compdef _brspec_all brspec_all
