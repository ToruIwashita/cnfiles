"" FILE: simple_git_commands.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s><C-a> :<C-u>wa<CR>:GAddAll<CR>:e!<CR>:<C-U>checktime<CR>
nnoremap <C-s><C-r> :<C-u>wa<CR>:GResetAll<CR>:e!<CR>:<C-U>checktime<CR>

nnoremap <C-s>P :<C-u>GllRebase

nnoremap <leader>ca :<C-u>GClean<CR>
nnoremap <leader>cm :<C-u>GCleanM<CR>
nnoremap <leader>cu :<C-u>GCleanU<CR>

cnoremap <C-g>i <RIGHT><C-r>=simple_git_commands#g_current_branch()<CR>
nnoremap <C-g>i :<C-u>GAppendCurrentBranch<CR>

nnoremap <C-g>h :<C-u>Gsh
nnoremap <C-g><C-h> :<C-u>GshForce

nnoremap <C-g>L :<C-u>GRecoverLatestRemote

nnoremap <C-g>H :<C-u>GResetHardLatest
nnoremap <C-g>M :<C-u>GResetMixedLatest
nnoremap <C-g>S :<C-u>GResetSoftLatest

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
