## curl関数用補完
_cl() {
  _arguments \
    '(-c --cookie)'{-c,--cookie}'[Cookie]' \
    '(-j --json)'{-j,--json}'["Accept: application/json" and "Content-Type: application/json" header]' \
    '(-p --params)'{-p,--params}'[Parameter]' \
    '--post[Post request]' \
    '(-v --verbose)'{-f,--fixup}'[verbose mode]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

compdef _cl cl
