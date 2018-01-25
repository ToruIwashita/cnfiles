"" FILE: insert_current_file_name.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>i :<C-u>InsertCurrentFileName<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
