"" FILE: ruby.vim
ab <buffer> =p binding.pry
ab <buffer> =8 # coding: utf-8

" makeで`ruby -w`起動
compiler ruby

augroup AuRbSyntaxCheck
  autocmd!
  " `BufWritePost`で`make -c`
  autocmd BufWritePost <buffer> silent make -c -W1 % | redraw!
  " `make`したら`quickfix`リストを表示
  autocmd QuickfixCmdPost make cw
augroup END
