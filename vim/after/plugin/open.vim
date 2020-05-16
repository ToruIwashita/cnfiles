"" FILE: open.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

vnoremap <C-s>- :<C-u>OpenRange<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
