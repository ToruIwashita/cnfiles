"" FILE: gtran_filter.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>. V:<C-u>GtranRangeFilter!<CR>
nnoremap <leader>/ V:<C-u>GtranRangeFilter<CR>
vnoremap <leader>. :<C-u>GtranRangeFilter!<CR>
vnoremap <leader>/ :<C-u>GtranRangeFilter<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
