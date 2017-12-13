"" FILE: delete_forword_line_after_specified_char.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:delete_forword_line_after_specified_char(char) range
  silent! execute a:firstline.','.a:lastline.'s/\(.*\)'.a:char.'.*/\1/g'
endf

command! -range -nargs=1 DeleteForwordLineAfterSpecifiedChar :<line1>,<line2>call s:delete_forword_line_after_specified_char(<f-args>)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
