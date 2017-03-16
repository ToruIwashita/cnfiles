## tpmで管理しているプラグインの設定を記述する

# resurrect
set -g @resurrect-save 'C-o'
set -g @resurrect-restore 'C-r'
set -g @resurrect-dir ~/.cache/tmux/resurrect

# prefix-highlight
set -g @prefix_highlight_fg 'colour223'
set -g @prefix_highlight_bg 'colour166'
set -g @prefix_highlight_show_copy_mode 'on'
set -g @prefix_highlight_copy_mode_attr 'fg=colour0,bg=colour3'
set -g @prefix_highlight_output_prefix ' '
set -g @prefix_highlight_output_suffix ' '
