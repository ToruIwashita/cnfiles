"" FILE: gitv.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:Gitv_OpenHorizontal = 1

nnoremap <leader>gl :<C-u>Gitv<CR>

fun! s:gitv_get_current_hash()
  return matchstr(getline('.'), '\[\zs.\{7\}\ze\]$')
endfunction

function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction

fun! s:gitv_settiongs()
  nnoremap <buffer> <leader>b :<C-u>Git rebase -i <C-r>=<SID>gitv_get_current_hash()<CR><CR>
  nnoremap <buffer> <leader>p :<C-u>Git cherry-pick <C-r>=<SID>gitv_get_current_hash()<CR><CR>
  nnoremap <buffer> <leader>r :<C-u>Git revert <C-r>=<SID>gitv_get_current_hash(<CR><CR>
  nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w
endf

" FileTypeがgitの場合に折りたたみを行わない
augroup local_gitv
  autocmd!
  autocmd FileType gitv call s:gitv_settiongs()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
