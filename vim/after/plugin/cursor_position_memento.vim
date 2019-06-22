"" FILE: cursor_position_mementor.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>_ :<C-u>LoadSpecificCursorPos<CR>
nnoremap <leader>. :<C-u>SaveSpecificCursorPos<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
