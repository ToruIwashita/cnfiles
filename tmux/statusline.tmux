## statusline

# status
set -g status-style fg=colour188,bg=colour234

# status-left
set -g status-left ''

# status-right
set -g status-right-length 150
set -g status-right '#{prefix_highlight} #[fg=colour38,bg=colour234,nobold]#($TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load/tmux-mem-cpu-load) #{?pane_synchronized,#[bg=colour54],#[bg=colour242]}#{?pane_synchronized,#[fg=colour231],#[fg=colour251]} sync#{?pane_synchronized,[*],[]}'

# window-status
setw -g window-status-format '#[fg=colour188,bg=colour234] #I #W '
setw -g window-status-current-format '#[fg=colour38,bg=colour20,noreverse,nobold] #I #W '
setw -g window-status-current-style fg=white,bg=colour234,bold

# pane
set -g pane-border-style fg=colour188,bg=colour16
set -g pane-active-border-style fg=colour188,bg=colour20
