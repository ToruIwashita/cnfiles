"" FILE: file_reload.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:reload_and_notify(message) abort
  " ファイルを強制的にリロード（変更は破棄）
  let l:msg_width = strdisplaywidth(a:message) " メッセージの表示幅

  " 現在のウィンドウの位置とサイズを取得
  let l:win_pos = win_screenpos(0)
  let l:win_height = winheight(0)
  let l:win_width = winwidth(0)

  " 現在のウィンドウの中央に表示するための座標計算
  let l:popup_line = l:win_pos[0] + (l:win_height / 2) - 2
  let l:popup_col = l:win_pos[1] + (l:win_width / 2) - (l:msg_width / 2)

  silent! edit!

  call popup_notification(a:message, {
    \ 'time': 1000,
    \ 'highlight': 'ModeMsg',
    \ 'line': l:popup_line,
    \ 'col': l:popup_col,
    \ 'padding': [0, 1, 0, 1],
    \ 'minwidth': l:msg_width,
    \ 'maxwidth': l:msg_width
  \ })
endfunction

command! -nargs=1 ReloadAndNotify call s:reload_and_notify(<q-args>)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
