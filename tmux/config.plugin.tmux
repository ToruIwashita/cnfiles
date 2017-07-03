## tpmで管理しているプラグインの設定を記述する

# tpm
set -g @tpm-install 'I'
set -g @tpm-update 'U'
set -g @tpm-clean 'C'

# resurrect
set -g @resurrect-save 'C-o'
set -g @resurrect-restore 'C-r'
set -g @resurrect-dir ~/.cache/tmux/resurrect

# prefix-highlight
set -g @prefix_highlight_fg 'colour78'
set -g @prefix_highlight_bg 'colour23'
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=colour221,bg=colour94'
set -g @prefix_highlight_output_prefix ' '
set -g @prefix_highlight_output_suffix ' '
