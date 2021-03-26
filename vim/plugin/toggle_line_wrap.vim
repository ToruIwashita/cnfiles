"" FILE: toggle_line_wrap.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:toggle_line_wrap()
  if &wrap
    set nowrap
  else
    set wrap
  endif
endf

command! ToggleLineWrap call s:toggle_line_wrap()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
