## statusline

# status
set -g status-style fg=colour188,bg=colour234

# status-left
set -g status-left ''

# status-right
set -g status-right-length 150
set -g status-right '#{prefix_highlight} #[fg=colour38,bg=colour234,nobold]#($TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load/tmux-mem-cpu-load -v -a 1) #{?pane_synchronized,#[bg=colour54],#[bg=colour242]}#{?pane_synchronized,#[fg=colour231],#[fg=colour251]} sync#{?pane_synchronized,[*],[]} #[fg=colour234,bg=colour38] #(cat $CURRENT_TMUX_AI_AGENT_FILE_PATH) '

# window-status
# @ai_state(ai-agent-stateが設定するwindowオプション)に応じてタブ色を切り替える
# blocked(承認・入力待ち)=黄 / done(完了)=赤 / それ以外=デフォルト色
setw -g window-status-format '#{?#{==:#{@ai_state},blocked},#[fg=colour16 bg=colour220],#{?#{==:#{@ai_state},done},#[fg=colour231 bg=colour167],#[fg=colour188 bg=colour234]}} #I #W '
setw -g window-status-current-format '#{?#{==:#{@ai_state},blocked},#[fg=colour16 bg=colour220],#{?#{==:#{@ai_state},done},#[fg=colour231 bg=colour167],#[fg=colour38 bg=colour20 noreverse nobold]}} #I #W '
setw -g window-status-current-style fg=white,bg=colour234,bold

# pane
set -g pane-border-style fg=colour188,bg=colour16
set -g pane-active-border-style fg=colour188,bg=colour20
