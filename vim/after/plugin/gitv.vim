"" FILE: gitv.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w>gv :<C-u>Gitv --all<Cr>
nnoremap <C-w>gV :<C-u>Gitv! --all<Cr>

let &cpo = s:cpo_save
unlet s:cpo_save
