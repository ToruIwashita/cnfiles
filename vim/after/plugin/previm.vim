"" FILE: previm.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:previm_enable_realtime = 1

fun! s:previm_setting() abort
  nnoremap <buffer> <C-s>v :<C-u>PrevimOpen<CR>
endf

augroup local_previm
  autocmd!
  autocmd FileType markdown call s:previm_setting()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
