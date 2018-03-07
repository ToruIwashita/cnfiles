## curl関数用補完
_cl() {
  _arguments \
    '(-j --json)'{-j,--json}'["Content-Type: application/json" header]' \
    '(-v --verbose)'{-f,--fixup}'[verbose mode]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

compdef _cl cl
