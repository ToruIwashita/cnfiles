"" FILE: simple_git_pull_rebase.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-g>B :GllRebase<SPACE>

let &cpo = s:cpo_save
unlet s:cpo_save
