"" FILE: open.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:open_range() abort range
  let line = line('.')
  let col  = col('.')
  let l:unnamed_register = @@
  silent! normal! gvy
  let l:selected_range = @@
  let @@ = l:unnamed_register

  if l:selected_range =~# "'"
    let l:escaped_selected_range = '"'.escape(l:selected_range, ' \"').'"'
  elseif l:selected_range =~# '[ \"]'
    let l:escaped_selected_range = string(l:selected_range)
  else
    let l:escaped_selected_range = l:selected_range
  endif

  execute '!open '.l:escaped_selected_range
  execute 'call cursor('.line.','.col.')'
endfunction

command -range OpenRange call s:open_range()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
