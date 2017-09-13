"" FILE: neosnippet.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>m :<C-u>Rename<SPACE>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
