"" FILE: google_search.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s><SPACE> :<C-u>GoogleSearch<SPACE>''<LEFT>
vnoremap <C-s><SPACE> :<C-u>GoogleSearchRange<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
