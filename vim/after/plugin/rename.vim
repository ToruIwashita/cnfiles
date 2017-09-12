"" FILE: neosnippet.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>m :<C-u>Rename<SPACE>

let &cpo = s:cpo_save
unlet s:cpo_save
