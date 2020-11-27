"" FILE: current_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

cnoremap <C-s>i <RIGHT><C-r>=expand('%:t:r')<CR>
cnoremap <C-s><C-i> <RIGHT><C-r>=expand('%:t')<CR>

nnoremap <C-s>i :<C-u>InsertCurrentFileName<CR>
nnoremap <C-s><C-i> :<C-u>InsertCurrentFileNameWithExt<CR>

nnoremap <C-s>a :<C-u>AppendCurrentFileName<CR>
nnoremap <C-s><C-a> :<C-u>AppendCurrentFileNameWithExt<CR>

nnoremap <C-s>c :<C-u>ChangeWordToCurrentFileName<CR>
nnoremap <C-s><C-c> :<C-u>ChangeWordToCurrentFileNameWithExt<CR>

nnoremap <C-s>y :<C-u>YankCurrentFilePath<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
