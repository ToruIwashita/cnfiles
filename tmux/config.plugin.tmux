## tpmで管理しているプラグインの設定を記述する

# tpm
set -g @tpm-install 'I'
set -g @tpm-update 'U'
set -g @tpm-clean 'C'

# resurrect
set -g @resurrect-save 'User0'
set -g @resurrect-restore 'User1'
set -g @resurrect-dir ~/.cache/tmux/resurrect
bind C-o confirm-before -p 'save tmux sessions? (y/n)' 'switch-client -T prefix ; send-keys -K User0'
bind C-r confirm-before -p 'restore tmux sessions? (y/n)' 'switch-client -T prefix ; send-keys -K User1'

# yank
# YはコピーしてCopy Modeを続けるキーに使うため,デフォルトのYをpへ移す
set -g @copy_mode_put 'p'

# prefix-highlight
set -g @prefix_highlight_fg 'colour78'
set -g @prefix_highlight_bg 'colour23'
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=colour221,bg=colour94'
set -g @prefix_highlight_output_prefix ' '
set -g @prefix_highlight_output_suffix ' '
