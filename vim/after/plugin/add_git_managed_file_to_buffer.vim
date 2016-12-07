"" FILE: add_git_managed_file_to_buffer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>ac :<C-u>AddCToBuffer<CR>
nnoremap <leader>am :<C-u>AddMToBuffer<CR>
nnoremap <leader>au :<C-u>AddUToBuffer<CR>
nnoremap <leader>tc :<C-u>AddCToTab<CR>
nnoremap <leader>tm :<C-u>AddMToTab<CR>
nnoremap <leader>tu :<C-u>AddUToTab<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
