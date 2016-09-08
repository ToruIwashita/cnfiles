"" FILE: ctrlp-modified.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>k :<C-u>CtrlPModified<CR>
nnoremap <C-s><C-k> :<C-u>CtrlPBranch<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
