"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>gb :<C-u>Gblame<CR>
nnoremap <leader>gd :<C-u>Gdiff<CR>
nnoremap <leader>gs :<C-u>Gstatus<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
