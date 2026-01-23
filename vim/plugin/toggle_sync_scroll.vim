"" FILE: toggle_sync_scroll.vim

set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:sync_scroll_enabled = 0

" lightline.vim依存のコード
fun! s:toggle_sync_scroll() abort
  if g:sync_scroll_enabled
    let g:sync_scroll_enabled = 0
    windo setlocal noscrollbind
  else
    let g:sync_scroll_enabled = 1
    windo setlocal scrollbind
  endif

  call lightline#update()
endf

command! ToggleSyncScroll call s:toggle_sync_scroll()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
