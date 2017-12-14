"" FILE: delete_forword_line_after_specified_word.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:delete_forword_line_after_specified_word() range
  echohl Question
  let l:input = input('deletion start position word: ')
  echohl None

  redraw!

  silent! execute a:firstline.','.a:lastline.'s/\(.*\)'.l:input.'.*/\1/g'
endf

command! -range DeleteForwordLineAfterSpecifiedWord :<line1>,<line2>call s:delete_forword_line_after_specified_word()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
