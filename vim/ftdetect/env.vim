" Detect .env

augroup ftdetect_env
  autocmd!
  autocmd BufNewFile,BufRead *.env,.env,.env.* setlocal filetype=conf
augroup END
