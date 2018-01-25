"" FILE: insert_current_file_name.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:insert_current_file_name()
  let l:pos = getpos('.')
  execute ':normal i' . expand('%:t:r')
  call setpos('.', l:pos)
endf

command! InsertCurrentFileName call s:insert_current_file_name()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
