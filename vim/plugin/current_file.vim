"" FILE: current_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:insert_current_file_name() abort
  let l:pos = getpos('.')
  execute ':normal i' . expand('%:t:r')
  call setpos('.', l:pos)
endf

fun! s:insert_current_file_name_with_ext() abort
  let l:pos = getpos('.')
  execute ':normal i' . expand('%:t')
  call setpos('.', l:pos)
endf

fun! s:append_current_file_name() abort
  let l:pos = getpos('.')
  execute ':normal a' . expand('%:t:r')
  call setpos('.', l:pos)
endf

fun! s:append_current_file_name_with_ext() abort
  let l:pos = getpos('.')
  execute ':normal a' . expand('%:t')
  call setpos('.', l:pos)
endf

fun! s:change_word_to_current_file_name() abort
  let l:pos = getpos('.')
  execute ':normal cw' . expand('%:t:r')
  call setpos('.', l:pos)
endf

fun! s:change_word_to_current_file_name_with_ext() abort
  let l:pos = getpos('.')
  execute ':normal cw' . expand('%:t')
  call setpos('.', l:pos)
endf

fun! s:yank_current_file_path() abort
  let @" = expand('%')
endf

command! InsertCurrentFileName call s:insert_current_file_name()
command! InsertCurrentFileNameWithExt call s:insert_current_file_name_with_ext()

command! AppendCurrentFileName call s:append_current_file_name()
command! AppendCurrentFileNameWithExt call s:append_current_file_name_with_ext()

command! ChangeWordToCurrentFileName call s:change_word_to_current_file_name()
command! ChangeWordToCurrentFileNameWithExt call s:change_word_to_current_file_name_with_ext()

command! YankCurrentFilePath call s:yank_current_file_path()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
