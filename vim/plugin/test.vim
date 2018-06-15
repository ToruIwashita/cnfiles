"" FILE: test.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:test()
endfunction

command! Test call s:test()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
