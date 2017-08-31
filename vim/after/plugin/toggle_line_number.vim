"" FILE: toggle_line_number.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-i><C-i> :<C-u>ToggleLineNumber<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
