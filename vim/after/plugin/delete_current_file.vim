"" FILE: delete_current_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>d :<C-u>BufferDeleteCurrentFile<CR>
nnoremap <leader>D :<C-u>DeleteCurrentFile<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
