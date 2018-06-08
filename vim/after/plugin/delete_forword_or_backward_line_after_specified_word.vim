"" FILE: delete_forword_or_backward_line_after_specified_word.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>@ :<C-u>%DeleteForwordLineAfterSpecifiedWord<CR>
vnoremap <C-s>@ :<C-u>'<,'>DeleteForwordLineAfterSpecifiedWord<CR>

nnoremap <C-s><C-@> :<C-u>%DeleteBackwardLineAfterSpecifiedWord<CR>
vnoremap <C-s><C-@> :<C-u>'<,'>DeleteBackwardLineAfterSpecifiedWord<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
