"" FILE: git_diff_viewer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>d :<C-u>GitDiffView<CR>
nnoremap <C-s><C-d> :<C-u>GitDiffView<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
