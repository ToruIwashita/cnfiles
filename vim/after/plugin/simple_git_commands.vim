"" FILE: simple_git_commands.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-g>i :<C-u>InsertCurrentBranch<CR>

nnoremap <C-g>h :<C-u>Gsh
nnoremap <C-g><C-h> :<C-u>GshForce

nnoremap <C-s><C-a> :<C-u>wa<CR>:<C-u>GAddAll<CR>:<C-u>e!<CR>:<C-U>checktime<CR>
nnoremap <C-s><C-r> :<C-u>wa<CR>:<C-u>GResetAll<CR>:<C-u>e!<CR>:<C-U>checktime<CR>

nnoremap <leader>ca :<C-u>GClean<CR>
nnoremap <leader>cm :<C-u>GCleanM<CR>
nnoremap <leader>cu :<C-u>GCleanU<CR>

nnoremap <C-g>B :<C-u>GllRebase

nnoremap <C-g>D :<C-u>GDeleteAllMergedBranch

nnoremap <C-g>H :<C-u>GResetHard

nnoremap <C-g>L :<C-u>GResetLatest

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
