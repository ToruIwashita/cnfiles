"" FILE: paste_yank.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:change_cursor_word_to_yank(adjust_cursor_position)
  let l:column_position = col('.')

  " dwだとwordの後に空白がある場合に空白も削除してしまう
  silent! normal! de

  if l:column_position !=# col('.')
    silent! normal! "0p
  else
    silent! normal! "0P
  endif

  if a:adjust_cursor_position ==# 1
    silent! normal! b
  endif
endfunction

command! ChangeCursorWordToYank call s:change_cursor_word_to_yank(0)
command! ChangeCursorWordToYankWithAdjustCursorPosition call s:change_cursor_word_to_yank(1)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
