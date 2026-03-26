## pbcopy bind
# 現在のペインターゲットを表示&クリップボードにコピー
bind b run-shell 'echo -n "#{session_name}:#{window_index}.#{pane_index}" | pbcopy' \; display-message "#{session_name}:#{window_index}.#{pane_index} (copied)"
