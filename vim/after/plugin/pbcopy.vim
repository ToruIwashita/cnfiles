"" FILE: pbcopy.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap <C-s>b :<C-u>wa<CR>:PbcopyBuffer<CR>
noremap <C-s><C-b> :<C-u>wa<CR>:PbcopyBuffer<CR>
noremap <C-s><C-y> :<C-u>PbcopyFilePath<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
