## curl関数用補完
__http-methods() {
  compadd DELETE GET PATCH POST PUT
}

_cl() {
  _arguments \
    '(-c --cookie)'{-c,--cookie}'[Set cookie]' \
    '(-j --json)'{-j,--json}'[With "Accept: application/json" and "Content-Type: application/json" header]' \
    '(-p --params)'{-p,--params}'[Set parameter]' \
    '(-r --request)'{-r,--request}'[Http method]: :__http-methods' \
    '(-v --verbose)'{-f,--fixup}'[Verbose mode]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

compdef _cl cl
