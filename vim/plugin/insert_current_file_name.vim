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

fun! s:insert_current_file_name_with_ext()
  let l:pos = getpos('.')
  execute ':normal i' . expand('%:t')
  call setpos('.', l:pos)
endf

command! InsertCurrentFileName call s:insert_current_file_name()
command! InsertCurrentFileNameWithExt call s:insert_current_file_name_with_ext()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
