"" FILE: simple_git_reset_latest_commit.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-g>r :GresetLatest

let &cpo = s:cpo_save
unlet s:cpo_save
