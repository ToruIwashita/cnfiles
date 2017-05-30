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
nnoremap <C-g><C-a> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>e!<CR>
nnoremap <C-g>c :<C-u>Gcommit -v<CR>
nnoremap <C-g><C-c> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit -v<CR>
nnoremap <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
nnoremap <C-g><C-t> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
nnoremap <C-g><C-v> :<C-u>Gblame<CR>

fun! s:fugitive_commit_setting()
  nnoremap <buffer> <C-g><C-c> <NOP>
  nnoremap <buffer> <C-g><C-t> <NOP>
  nnoremap <buffer> <C-g>d :<C-u>Git diff <C-r>=matchstr(getline('.'), 'modified:\s*\zs.*\ze')<CR><CR>

  " タブで開く
  nmap <buffer> t O
  " リロード
  nmap <buffer> <leader>r r
  " 変更を取り消し
  nmap <buffer> ! U

  " コミットコメントの為のローカル設定
  ab <buffer> =r refs #<C-r>=split(fugitive#head(), '-')[1]<CR>
endf

fun! s:fugitive_blame_setting()
  nnoremap <buffer> <C-s><C-g> :<C-u>Gbrowse <C-r>=matchstr(getline('.'), '^\zs[0-9a-f]\{7,10\}\ze')<CR><CR>
endf

augroup local_fugitive
  autocmd!
  autocmd FileType gitcommit call s:fugitive_commit_setting()
  autocmd FileType fugitiveblame call s:fugitive_blame_setting()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
