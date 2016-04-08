"" FILE: ansi_escape_sequence.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

function! s:remove_ansi_code(line1,line2)
  silent! execute a:line1.','.a:line2.'s/\%V\e\[\d\{1,3}[mK]//g'
endfunction

command! -range RemoveAnsiCode call s:remove_ansi_code(<line1>,<line2>)

let &cpo = s:cpo_save
unlet s:cpo_save
