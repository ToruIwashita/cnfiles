"" FILE: gitv.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" Gitvを水平分割
let g:Gitv_OpenHorizontal = 1
" コミットメッセージが長い場合は隠す
let g:Gitv_TruncateCommitSubjects = 1

nnoremap <C-g>v :<C-u>Gitv!<CR>
nnoremap <C-g>l :<C-u>Gitv<CR>

fun! s:gitv_get_current_sha()
  return matchstr(getline('.'), '\[\zs[0-9a-f]\{7,10\}\ze\]$')
endfunction

function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction

fun! s:gitv_settiongs()
  " foldingをトグル
  nnoremap <silent><buffer> t :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w

  " gitvはfugitiveに依存しているのでここでfugitiveのコマンドを使用することを許容する
  nnoremap <buffer> <C-g>B :<C-u>Git rebase -i <C-r>=<SID>gitv_get_current_sha()<CR><CR>
  nnoremap <buffer> <C-g>C :<C-u>Git cherry-pick <C-r>=<SID>gitv_get_current_sha()<CR><CR>
  nnoremap <buffer> <C-g>R :<C-u>Git revert <C-r>=<SID>gitv_get_current_sha()<CR><CR>
  nnoremap <buffer> <C-s><C-g> :<C-u>Gbrowse <C-r>=<SID>gitv_get_current_sha()<CR><CR>

  " リロード
  nmap <buffer> <leader>r u
endf

augroup local_gitv
  autocmd!
  autocmd FileType gitv call s:gitv_settiongs()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
