"" FILE: delete_current_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>d :<C-u>BufferDeleteCurrentFile<CR>
nnoremap <leader>D :<C-u>DeleteCurrentFile<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
