"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" <C-s>プレフィックス
nnoremap <C-s><C-u> :<C-u>Gstatus<CR>

" <C-g>プレフィックス
nnoremap <C-g>d :<C-u>Gdiff<CR>
nnoremap <C-g>s :<C-u>Git stash
nnoremap <C-g>a :<C-u>w<CR>:<C-u>Gwrite<CR>
nnoremap <C-g>c :<C-u>Gcommit -v<CR>
nnoremap <C-g><C-c> :<C-u>Gwrite<CR>:<C-u>Gcommit -v<CR>
nnoremap <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
nnoremap <C-g><C-t> :<C-u>Gwrite<CR>:<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
nnoremap <C-g><C-v> :<C-u>Gblame<CR>

fun! s:fugitive_settings()
  nnoremap <buffer> <C-g><C-c> <NOP>
  nnoremap <buffer> <C-g><C-t> <NOP>
  nnoremap <buffer> <C-g>d :<C-u>Git diff <C-r>=matchstr(getline('.'), 'modified:\s*\zs.*\ze')<CR><CR>
  nmap <buffer> t O

  " コミットコメントの為のローカル設定
  ab <buffer> =r refs #<C-r>=split(fugitive#head(), '-')[1]<CR>
endf

augroup local_fugitive
  autocmd!
  autocmd FileType gitcommit call s:fugitive_settings()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
