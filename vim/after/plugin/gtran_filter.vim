"" FILE: gtran_filter.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>s, V:<C-u>GtranRangeFilter<CR>
nnoremap <leader>s. V:<C-u>GtranRangeFilter!<CR>
vnoremap <leader>s, :<C-u>GtranRangeFilter<CR>
vnoremap <leader>s. :<C-u>GtranRangeFilter!<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
