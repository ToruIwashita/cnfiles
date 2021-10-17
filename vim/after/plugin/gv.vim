"" FILE: gv.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-g>v :<C-u>GV!<CR>
nnoremap <C-g>l :<C-u>GV<CR>

fun! s:gv_get_current_sha() abort
  return matchstr(getline('.'), '[*|] [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} \zs[0-9a-f]\{7,10\}\ze')
endf

fun! s:gv_settiongs() abort
  " リロード
  nnoremap <buffer> <leader>r :<C-u>q<CR>:GV<CR>

  " gvはfugitiveに依存している,以下はfugitive.vim依存のコード
  nnoremap <buffer> <C-g>B :<C-u>let g:_current_sha='<C-r>=<SID>gv_get_current_sha()<CR>'<CR>:G<CR>:execute 'Git rebase --interactive '.g:_current_sha<CR>
  nnoremap <buffer> <C-s>B :<C-u>Git rebase --ignore-date origin/HEAD
  nnoremap <buffer> <C-g>R :<C-u>Git revert <C-r>=<SID>gv_get_current_sha()<CR><CR>
  nnoremap <buffer> <C-s>G :<C-u>Gbrowse <C-r>=<SID>gv_get_current_sha()<CR><CR>
endf

augroup local_gv
  autocmd!
  autocmd FileType GV call s:gv_settiongs()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
