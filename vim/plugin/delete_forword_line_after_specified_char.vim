"" FILE: delete_forword_line_after_specified_char.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:delete_forword_line_after_specified_char() range
  let l:input = input('deletion start position char: ')

  redraw!

  silent! execute a:firstline.','.a:lastline.'s/\(.*\)'.l:input.'.*/\1/g'
endf

command! -range DeleteForwordLineAfterSpecifiedChar :<line1>,<line2>call s:delete_forword_line_after_specified_char()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
