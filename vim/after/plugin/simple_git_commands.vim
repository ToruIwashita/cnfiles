"" FILE: simple_git_commands.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-g>p :<C-u>Gsh
nnoremap <C-g><C-p> :<C-u>GshForce

nnoremap <C-g>B :GllRebase

nnoremap <C-g>R :GresetLatest

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
