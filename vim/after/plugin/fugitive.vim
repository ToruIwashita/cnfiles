"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>gb :<C-u>Gblame<CR>
nnoremap <leader>gd :<C-u>Gdiff<CR>
nnoremap <leader>gs :<C-u>Gstatus<CR>
nnoremap <leader>ga :<C-u>Gwrite<CR>
nnoremap <leader>gc :<C-u>Gcommit -v<CR>
nnoremap <leader>gt :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("date"), "\n$", "", "")<CR>'<CR>

fun! s:fugitive_settings()
  nnoremap <silent><buffer> <leader>gc :<C-u>Gcommit -v<CR>
  nnoremap <silent><buffer> <leader>gt :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("date"), "\n$", "", "")<CR>'<CR>
  nmap <buffer> t O
endf

augroup local_fugitive
  autocmd!
  autocmd FileType gitcommit call s:fugitive_settings()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
