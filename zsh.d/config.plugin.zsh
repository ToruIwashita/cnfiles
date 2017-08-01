## zsh-history-substring-search
bindkey -v '^n' history-substring-search-down  # Ctrl+nで部分文字列検索,下
bindkey -v '^p' history-substring-search-up    # Ctrl+pで部分文字列検索,上

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white'
