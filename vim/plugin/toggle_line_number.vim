"" FILE: toggle_line_number.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:toggle_line_number()
  if &number
    sign unplace *
    set nonumber
  else
    set number
  endif
endf

command! ToggleLineNumber call s:toggle_line_number()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
