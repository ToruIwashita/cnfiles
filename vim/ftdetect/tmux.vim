" Detect *.tmux
autocmd BufNewFile,BufRead *.tmux setlocal filetype=tmux | compiler tmux
