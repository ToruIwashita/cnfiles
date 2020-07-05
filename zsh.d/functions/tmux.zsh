## tmux
tmux-display-message() {
  local display_duration saved_display_time

  display_duration=10000
  saved_display_time=$(tmux show-option -gqv display-time)

  tmux set-option -gq display-time $display_duration
  tmux display-message "$1"
  tmux set-option -gq display-time $saved_display_time
}
