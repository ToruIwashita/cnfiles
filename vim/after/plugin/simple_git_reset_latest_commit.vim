"" FILE: simple_git_reset_latest_commit.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-g>R :GresetLatest

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
