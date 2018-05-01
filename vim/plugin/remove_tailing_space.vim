"" FILE: remove_tailing_space.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:remove_tailing_space_range() range
  silent! execute a:firstline.','.a:lastline.'s/ *$//'
endfunction

command! -range RemoveTailingSpace :<line1>,<line2>call s:remove_tailing_space_range()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
