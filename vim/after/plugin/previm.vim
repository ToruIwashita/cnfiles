"" FILE: previm.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:previm_enable_realtime = 1

fun! s:previm_setting()
  nnoremap <buffer> <leader>p :<C-u>PrevimOpen<CR>
endf

augroup local_previm
  autocmd!
  autocmd FileType markdown call s:previm_setting()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
