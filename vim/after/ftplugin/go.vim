"" FILE: go.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

"" シンタクスハイライト
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" errという文字列のシンタクスハイライト
augroup local_go_vim
  autocmd!
  autocmd BufEnter *.go highlight goErr cterm=bold ctermfg=214
  autocmd BufEnter *.go match goErr /\<err\>/
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
