"" FILE: text.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" textはテキストの最大幅無し
setlocal textwidth=0

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
