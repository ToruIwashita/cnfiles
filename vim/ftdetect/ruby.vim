" Detect pryrc,aprc

augroup ftdetect_ruby
  autocmd!
  autocmd BufNewFile,BufRead pryrc,aprc,.aprc setlocal filetype=ruby
  autocmd BufNewFile,BufRead *.mobile.erb setlocal filetype=eruby.html
augroup END
