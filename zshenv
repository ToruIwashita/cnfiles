## ログインと同時にtmuxアタッチ
if [ -z "$TMUX" -a -z "$STY" ]; then
  if type tmuxx >/dev/null 2>&1; then
    tmuxx
  elif type tmux >/dev/null 2>&1; then
    if tmux has-session; then
      tmux -u attach && echo "tmux attached session "
    else
      tmux -u new-session -s IwashitaDev && echo "tmux created new session"
    fi
  elif type screen >/dev/null 2>&1; then
    screen -rx || screen -D -RR
  fi
fi
