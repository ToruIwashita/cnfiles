"" FILE: pbcopy.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap <C-s>b :<C-u>wa<CR>:<C-u>PbcopyBuffer<CR>
noremap <C-s><C-b> :<C-u>wa<CR>:<C-u>PbcopyBuffer<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
