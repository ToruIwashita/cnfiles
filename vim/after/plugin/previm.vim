"" FILE: previm.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:previm_enable_realtime = 1

nnoremap <leader>p :<C-u>PrevimOpen<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
