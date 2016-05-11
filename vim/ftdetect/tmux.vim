" Detect *.tmux

augroup ftdetect_tmux
  autocmd!
  autocmd BufNewFile,BufRead *.tmux setlocal filetype=tmux | compiler tmux
augroup END
