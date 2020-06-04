## peco-kill-ps
_peco-kill-ps() {
  _arguments \
    '(-f --force)'{-f,--force}'[Kill without confirmation]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

compdef _peco-kill-ps peco-kill-ps
