"" FILE: insert_current_file_name.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

cnoremap <C-s>i <RIGHT><C-r>=expand('%:t:r')<CR>
cnoremap <C-s><C-i> <RIGHT><C-r>=expand('%:t')<CR>

nnoremap <C-s>i :<C-u>InsertCurrentFileName<CR>
nnoremap <C-s><C-i> :<C-u>InsertCurrentFileNameWithExt<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
