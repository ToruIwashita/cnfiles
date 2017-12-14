"" FILE: delete_forword_line_after_specified_word.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s><C-@> :<C-u>DeleteForwordLineAfterSpecifiedWord<CR>
vnoremap <C-s><C-@> :<C-u>'<,'>DeleteForwordLineAfterSpecifiedWord<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
