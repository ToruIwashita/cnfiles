"" FILE: google_search.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:google_search()
    let l:line = line('.')
    let l:col  = col('.')
    let l:search_word = expand('<cword>')

    execute 'read !open https://www.google.co.jp/search\?q\='.l:search_word
    execute 'call cursor('.line.','.col.')'
endfunction

function! s:google_search_range() range
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

  execute 'read !open https://www.google.co.jp/search\?q\='.l:escaped_selected_range
  execute 'call cursor('.line.','.col.')'
endfunction

command GoogleSearch call s:google_search()
command! -range GoogleSearchRange call s:google_search_range()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
