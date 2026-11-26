"" FILE: git_switcher.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:gsw_autoload_session = 'confirm'
let g:gsw_save_session_confirm = 'no'
let g:gsw_load_session_confirm = 'yes'
let g:gsw_switch_prev_confirm = 'yes'

fun! s:confirmed(message)
  echo a:message.' (Y)es, (N)o: '
  let l:answer = getcharstr()
  redraw
  if l:answer !=? 'y'
    echo ''
    return 0
  endif

  return 1
endf

fun! s:confirm_gsw_save()
  if !s:confirmed('save session?')
    return
  endif

  GswSave
endf

fun! s:confirm_gsw_load()
  if !s:confirmed('load session?')
    return
  endif

  GswLoad
endf

command! ConfirmGswSave call s:confirm_gsw_save()
command! ConfirmGswLoad call s:confirm_gsw_load()

" <C-s>プレフィックス
nnoremap <C-s>p :<C-u>GswPull!<CR>
nnoremap <C-s>n :<C-u>GswFetch!<CR>

" <C-w>プレフィックス
nnoremap <C-w><C-o> :<C-u>ConfirmGswSave<CR>
nnoremap <C-w>o :<C-u>GswSave<SPACE>
nnoremap <C-w><C-r> :<C-u>ConfirmGswLoad<CR>
nnoremap <C-w>r :<C-u>GswLoad<SPACE>

" <C-g>プレフィックス
nnoremap <C-g>g :<C-u>Gsw<SPACE>
nnoremap <C-g><C-g> :<C-u>GswRemote<SPACE>
nnoremap <C-g>m :<C-u>GswMove<SPACE>
nnoremap <C-g><C-m> :<C-u>GswMove<SPACE><C-r>=split(system('\git rev-parse --abbrev-ref HEAD 2>/dev/null'), "\n")[0]<CR>
nnoremap <C-g>r :<C-u>GswRemove<SPACE>
nnoremap <C-g>_ :<C-u>GswPrev<CR>
nnoremap <C-g>b :<C-u>GswBranch<CR>
nnoremap <C-g><C-b> :<C-u>GswBranchRemote<CR>
nnoremap <C-g>@ :<C-u>GswClearState
nnoremap <C-g>D :<C-u>GswRemoveMergedBranches
nnoremap <C-g>; :<C-u>GswDeleteSessionsIfBranchNotExists

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
