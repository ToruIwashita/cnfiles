"" FILE: append_current_file_name.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:append_current_file_name()
  let l:pos = getpos('.')
  execute ':normal a' . expand('%:t:r')
  call setpos('.', l:pos)
endf

fun! s:append_current_file_name_with_ext()
  let l:pos = getpos('.')
  execute ':normal a' . expand('%:t')
  call setpos('.', l:pos)
endf

command! AppendCurrentFileName call s:append_current_file_name()
command! AppendCurrentFileNameWithExt call s:append_current_file_name_with_ext()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
