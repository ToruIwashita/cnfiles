"" FILE: tcomment.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap ! :<C-u>TComment<CR>
vnoremap ! :<C-u>'<,'>TComment<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
