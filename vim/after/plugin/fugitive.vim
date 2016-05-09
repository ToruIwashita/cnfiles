"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" <C-s>プレフィックス
nnoremap <C-s>i :<C-u>Gstatus<CR>

" <C-g>プレフィックス
nnoremap <C-g>d :<C-u>Gdiff<CR>
nnoremap <C-g>a :<C-u>Gwrite<CR>
nnoremap <C-g>c :<C-u>Gcommit -v<CR>
nnoremap <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("date"), "\n$", "", "")<CR>'<CR>
nnoremap <C-g><C-v> :<C-u>Gblame<CR>
nnoremap <C-g><C-t> :<C-u>Gwrite<CR>:<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("date"), "\n$", "", "")<CR>'<CR>

fun! s:fugitive_settings()
  nnoremap <silent><buffer> <C-g>c :<C-u>Gcommit -v<CR>
  nnoremap <silent><buffer> <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("date"), "\n$", "", "")<CR>'<CR>
  nmap <buffer> t O
endf

augroup local_fugitive
  autocmd!
  autocmd FileType gitcommit call s:fugitive_settings()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
