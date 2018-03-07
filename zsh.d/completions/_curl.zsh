## curl関数用補完
_cl() {
  _arguments \
    '(-c --cookie)'{-c,--cookie}'[Set cookie]' \
    '(-j --json)'{-j,--json}'[With "Accept: application/json" and "Content-Type: application/json" header]' \
    '(-p --params)'{-p,--params}'[Set parameter]' \
    '--post[Post request]' \
    '(-v --verbose)'{-f,--fixup}'[Verbose mode]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

compdef _cl cl
