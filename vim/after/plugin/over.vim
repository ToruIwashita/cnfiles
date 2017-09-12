"" FILE: over.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>o :<C-u>OverCommandLine<CR>%s///g<LEFT><LEFT><LEFT>

vnoremap <C-s>o :<C-u>'<,'>OverCommandLine<CR>%s///g<LEFT><LEFT><LEFT>

let &cpo = s:cpo_save
unlet s:cpo_save
