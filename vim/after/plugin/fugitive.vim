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
nnoremap <C-g>c :<C-u>Git commit -v<CR>
nnoremap <C-g><C-c> :<C-u>w<CR>:Gwrite<CR>:Git commit -v<CR>
" commit amend
nnoremap <C-g>w :<C-u>Git commit --amend<CR>
" empty commit
nnoremap <C-g>e :<C-u>Git commit --allow-empty -m '[empty commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
" temporary commit
nnoremap <C-g>t :<C-u>Git commit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>:e!<CR>:syntax sync fromstart<CR>
nnoremap <C-g><C-t> :<C-u>w<CR>:Gwrite<CR>:Git commit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>:e!<CR>:syntax sync fromstart<CR>
" fixup commit
nnoremap <C-g>f :<C-u>Git commit --amend --no-edit<CR>:e!<CR>:syntax sync fromstart<CR>
nnoremap <C-g><C-f> :<C-u>w<CR>:Gwrite<CR>:Git commit --amend --no-edit<CR>:e!<CR>:syntax sync fromstart<CR>
" add
nnoremap <C-g><C-a> :<C-u>w<CR>:Gwrite<CR>

" blame
nnoremap <C-g><C-v> :<C-u>Gblame<CR>

" rebase
nnoremap <buffer> <C-g>B :<C-u>Git rebase --interactive origin/HEAD
nnoremap <buffer> <C-s>B :<C-u>Git rebase --ignore-date origin/HEAD

fun! s:fugitive_commit_setting() abort
  nnoremap <buffer> <C-g><C-c> <NOP>
  nnoremap <buffer> <C-g><C-t> <NOP>

  " add
  map <buffer> a -

  " git status close
  nmap <buffer> q gq
  " タブで開く
  nmap <buffer> t O
  " リロード
  nmap <buffer> <leader>r r
  " 変更を取り消し
  nmap <buffer> ! X
  " short diff toggle
  nmap <buffer> o =
  " diff
  nmap <buffer> <C-g><C-d> D
  " add all
  nmap <silent><buffer> <C-s><C-a> :<C-u>wa<CR>:call system('\git add $(\git rev-parse --show-cdup).')<CR>r
  " reset all
  nmap <silent><buffer> <C-s><C-r> :<C-u>wa<CR>:call system('\git reset')<CR>r

  " empty commit
  nnoremap <C-g>e :<C-u>Git commit --alow-empty -m '[empty commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
  " temporary commit
  nnoremap <C-g>t :<C-u>Git commit -m '[temporary commit](<C-r>=fugitive#head()<CR>) <C-r>=substitute(system("LANG=C date"), "\n$", "", "")<CR>'<CR>
  " fixup commit
  nnoremap <C-g>f :<C-u>Git commit --amend --no-edit<CR>
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
