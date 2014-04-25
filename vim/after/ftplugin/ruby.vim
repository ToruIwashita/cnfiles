"" FILE: ruby.vim
let s:cpo_save = &cpo
set cpo&vim

" RubyCursorIdentifier()とタブ移動のmap競合を解消
silent! nunmap <buffer> <C-w>]
silent! nunmap <buffer> <C-w><C-]>

ab <buffer> =p binding.pry
ab <buffer> =8 # coding: utf-8
ab <buffer> =c , current: true

" makeで`ruby -w`起動
compiler ruby

augroup AuRbSyntaxCheck
  autocmd!
  " `BufWritePost`で`make -c`
  autocmd BufWritePost *.rb silent make -c -W1 % | redraw!
  " `make`したら`quickfix`リストを表示
  autocmd QuickfixCmdPost make cw
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
