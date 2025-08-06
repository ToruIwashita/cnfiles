## claude_monitor
__claude_plans() {
  compadd \
    'pro' \
    'max5' \
    'max20' \
    'custom'
}

_watch-claude() {
  _arguments \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '1: :__claude_plans'
}

compdef _watch-claude watch-claude
