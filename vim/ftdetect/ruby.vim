" Detect aprc

augroup ftdetect_ruby
  autocmd!
  autocmd BufNewFile,BufRead aprc,.aprc setlocal filetype=ruby
  autocmd BufNewFile,BufRead *.mobile.erb setlocal filetype=eruby.html
augroup END
