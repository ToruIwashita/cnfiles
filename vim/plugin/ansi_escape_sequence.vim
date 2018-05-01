"" FILE: ansi_escape_sequence.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:remove_ansi_code(line1,line2)
  silent! execute a:line1.','.a:line2.'s/\%V\e\[\d\{1,3}[mK]//g'
endfunction

command! -range RemoveAnsiCode call s:remove_ansi_code(<line1>,<line2>)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
