"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" <C-s>プレフィックス
" status
nnoremap <C-s><C-u> :<C-u>Gstatus<CR>

" <C-g>プレフィックス
" diff
nnoremap <C-g><C-d> :<C-u>Gdiff<CR>
" stash
nnoremap <C-g>ss :<C-u>Git stash save
nnoremap <C-g>sp :<C-u>Git stash pop
" commit
nnoremap <C-g>c :<C-u>Gcommit -v<CR>
nnoremap <C-g><C-c> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit -v<CR>
" temporary commit
nnoremap <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
nnoremap <C-g><C-t> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
" fixup commit
nnoremap <C-g>f :<C-u>Gcommit --amend --no-edit<CR>
nnoremap <C-g><C-f> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit --amend --no-edit<CR>
" add
nnoremap <C-g><C-a> :<C-u>w<CR>:<C-u>Gwrite<CR>

" blame
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
  " diff
  nmap <buffer> <C-g><C-d> D
  " add
  nmap <silent><buffer> <C-g>A :<C-u>wa<CR>:<C-u>call system('\git add $(\git rev-parse --show-cdup).')<CR>r
  " reset
  nmap <silent><buffer> <C-g>@ :<C-u>wa<CR>:<C-u>call system('\git reset')<CR>r
endf

fun! s:fugitive_blame_setting()
  nnoremap <buffer> <C-s><C-g> :<C-u>Gbrowse <C-r>=matchstr(getline('.'), '^\zs[0-9a-f]\{7,10\}\ze')<CR><CR>
endf

augroup local_fugitive
  autocmd!
  autocmd FileType gitcommit call s:fugitive_commit_setting()
  autocmd FileType fugitiveblame call s:fugitive_blame_setting()
augroup END

let s:cpoptions_save = &cpoptions
set cpoptions&vim
