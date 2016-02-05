## peco-kill-ps補完
_peco-kill-ps() {
  _arguments \
    '(-f --force)'{-f,--force}'[Kill without confirmation]' \
    '(-h --help)'{-h,--help}'[Show this help text]'
}

compdef _peco-kill-ps peco-kill-ps
