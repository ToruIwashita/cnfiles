"" FILE: ansi_escape_sequence.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:remove_ansi_code() abort range
  silent! execute a:firstline.','.a:lastline.'s/\%V\e\[\d\{1,3}[mK]//g'
endfunction

command! -range RemoveAnsiCode :let pos = getpos('.') | <line1>,<line2>call s:remove_ansi_code() | call setpos('.', pos) | unlet pos

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
