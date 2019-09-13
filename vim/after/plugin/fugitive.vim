"" FILE: fugitive.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" <C-s>プレフィックス
" status
nnoremap <C-s><C-u> :<C-u>G<CR>
" diff
nnoremap <C-s>u :<C-u>Git diff<CR>

" <C-g>プレフィックス
" diff
nnoremap <C-g><C-d> :<C-u>Gdiff<CR>
" stash
nnoremap <C-g>ss :<C-u>Git stash save
nnoremap <C-g>sp :<C-u>Git stash pop
" commit
nnoremap <C-g>c :<C-u>Gcommit -v<CR>
nnoremap <C-g><C-c> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit -v<CR>
" empty commit
nnoremap <C-g>e :<C-u>Gcommit --allow-empty -m '[empty commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
" temporary commit
nnoremap <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>:<C-u>e!<CR>:<C-u>syntax sync fromstart<CR>
nnoremap <C-g><C-t> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>:<C-u>e!<CR>:<C-u>syntax sync fromstart<CR>
" fixup commit
nnoremap <C-g>f :<C-u>Gcommit --amend --no-edit<CR>:<C-u>e!<CR>:<C-u>syntax sync fromstart<CR>
nnoremap <C-g><C-f> :<C-u>w<CR>:<C-u>Gwrite<CR>:<C-u>Gcommit --amend --no-edit<CR>:<C-u>e!<CR>:<C-u>syntax sync fromstart<CR>
" add
nnoremap <C-g><C-a> :<C-u>w<CR>:<C-u>Gwrite<CR>

" blame
nnoremap <C-g><C-v> :<C-u>Gblame<CR>

fun! s:fugitive_commit_setting() abort
  nnoremap <buffer> <C-g><C-c> <NOP>
  nnoremap <buffer> <C-g><C-t> <NOP>
  nnoremap <buffer> <C-g>d :<C-u>Git diff <C-r>=matchstr(getline('.'), 'M \s*\zs.*\ze')<CR><CR>

  " タブで開く
  nmap <buffer> t O
  " リロード
  nmap <buffer> <leader>r r
  " 変更を取り消し
  nmap <buffer> ! X
  " diff
  nmap <buffer> <C-g><C-d> D
  " add
  nmap <silent><buffer> <C-s><C-a> :<C-u>wa<CR>:<C-u>call system('\git add $(\git rev-parse --show-cdup).')<CR>r
  " reset
  nmap <silent><buffer> <C-s><C-r> :<C-u>wa<CR>:<C-u>call system('\git reset')<CR>r
  " empty commit
  nnoremap <C-g>e :<C-u>Gcommit --alow-empty -m '[empty commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
  " temporary commit
  nnoremap <C-g>t :<C-u>Gcommit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
  " fixup commit
  nnoremap <C-g>f :<C-u>Gcommit --amend --no-edit<CR>
endf

fun! s:fugitive_blame_setting() abort
  nnoremap <buffer> <C-s>G :<C-u>Gbrowse <C-r>=matchstr(getline('.'), '^\zs[0-9a-f]\{7,10\}\ze')<CR><CR>
endf

augroup local_fugitive
  autocmd!
  autocmd FileType fugitive call s:fugitive_commit_setting()
  autocmd FileType fugitiveblame call s:fugitive_blame_setting()
augroup END

let s:cpoptions_save = &cpoptions
set cpoptions&vim
