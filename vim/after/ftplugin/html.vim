"" FILE: html.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <buffer> <C-s>v :<C-u>w<CR>:OpenInBrowser<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
