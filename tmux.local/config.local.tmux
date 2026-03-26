## pbcopy bind
# 現在のペインターゲットを表示&クリップボードにコピー
bind b run-shell 'echo "#{session_name}:#{window_index}.#{pane_index}" | tr -d "\n" | pbcopy' \; display-message "#{session_name}:#{window_index}.#{pane_index} (copied)"
