"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>gb :<C-u>Gblame<CR>
nnoremap <leader>gd :<C-u>Gdiff<CR>
nnoremap <leader>gs :<C-u>Gstatus<CR><C-w>T

fun! s:fugitive_settings()
  nnoremap <buffer> <leader>c :<C-u>Gcommit<CR>
  nnoremap <buffer> <leader>t :<C-u>Gcommit -m '[temporary commit]'<CR>
  nmap <buffer> t O
endf

augroup local_fugitive
  autocmd!
  autocmd FileType gitcommit call s:fugitive_settings()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
