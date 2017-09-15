"" FILE: simple_git_commands.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-g>p :<C-u>Gsh
nnoremap <C-g><C-p> :<C-u>GshForce

nnoremap <C-g>@ :<C-u>GResetAll<CR>

nnoremap <leader>ca :<C-u>GClean<CR>
nnoremap <leader>cm :<C-u>GCleanM<CR>
nnoremap <leader>cu :<C-u>GCleanU<CR>

nnoremap <C-g>B :GllRebase

nnoremap <C-g>R :GResetLatest

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
