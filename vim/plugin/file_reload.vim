"" FILE: file_reload.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:reload_and_notify(message) abort
  " ファイルを強制的にリロード（変更は破棄）
  let l:msg_width = strdisplaywidth(a:message) " メッセージの表示幅
  let l:popup_line = &lines - 4                " 下から4行目に表示
  let l:popup_col = &columns - l:msg_width     " 右端からメッセージ幅分左にオフセット

  " 画面左端より左に行かないように調整
  if l:popup_col < 1
    let l:popup_col = 1
  endif

  silent! edit!

  call popup_notification(a:message, {
    \ 'time': 2000,
    \ 'highlight': 'ModeMsg',
    \ 'line': l:popup_line,
    \ 'col': l:popup_col
  \ })
endfunction

command! -nargs=1 ReloadAndNotify call s:reload_and_notify(<q-args>)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
