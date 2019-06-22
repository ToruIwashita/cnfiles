## statusline

# status
set -g status-style fg=colour188,bg=colour234

# status-left
set -g status-left-length 32
set -g status-left '#[fg=colour223,bg=colour166,nobold] #(whoami) '

# status-right
set -g status-right-length 150
set -g status-right '#{prefix_highlight} #[fg=colour38,bg=colour234,nobold]#(tmux-mem-cpu-load) #[fg=colour223,bg=colour166,nobold] [%Y-%m-%d(%a) %H:%M] '

# window-status
setw -g window-status-format '#[fg=colour188,bg=colour234] #I #W '
setw -g window-status-current-format '#[fg=colour38,bg=colour20,noreverse,nobold] #I #W '
setw -g window-status-current-style fg=white,bg=colour234,bold

# pane
set -g pane-border-style fg=colour188,bg=colour16
set -g pane-active-border-style fg=colour188,bg=colour20
