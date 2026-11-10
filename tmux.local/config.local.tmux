## pbcopy bind
# 現在のペインターゲットを表示&クリップボードにコピー
bind b run-shell 'echo "#{session_name}:#{window_index}.#{pane_index}" | tr -d "\n" | pbcopy' \; display-message "#{session_name}:#{window_index}.#{pane_index} (copied)"
# 選択範囲を行頭の空白と改行を除いた1行のコマンドにしてコピー(Claude Code が折り返して描いたコマンド用)
bind -T copy-mode-vi C-y send -X copy-pipe-and-cancel 'sed -E -e "/^ *$/d" -e "s/^ +//" -e "s/ +$//" -e "s/ *[\]$//" | paste -sd " " - | tr -d "\n" | pbcopy'
