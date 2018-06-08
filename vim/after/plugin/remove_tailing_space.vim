"" FILE: remove_tailing_space.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>@ :<C-u>%RemoveTailingSpace<CR>
vnoremap <leader>@ :<C-u>'<,'>RemoveTailingSpace<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
