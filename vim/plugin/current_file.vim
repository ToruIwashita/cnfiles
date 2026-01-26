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

fun! s:yank_current_file_name() abort
  let @" = expand('%:t')
endf

fun! s:yank_current_full_file_path() abort
  let l:full_path = expand('%:p')
  let l:home = expand('~')
  if l:full_path =~# '^' . l:home
    let @" = substitute(l:full_path, '^' . l:home, '~', '')
  else
    let @" = l:full_path
  endif
endf

fun! s:yank_current_full_dir_path() abort
  let l:full_path = expand('%:p:h')
  let l:home = expand('~')
  if l:full_path =~# '^' . l:home
    let @" = substitute(l:full_path, '^' . l:home, '~', '') . '/'
  else
    let @" = l:full_path . '/'
  endif
endf

fun! s:clear_file_and_insert_mode() abort
  execute ':%d'
  startinsert
endf

command! InsertCurrentFileName call s:insert_current_file_name()
command! InsertCurrentFileNameWithExt call s:insert_current_file_name_with_ext()

command! AppendCurrentFileName call s:append_current_file_name()
command! AppendCurrentFileNameWithExt call s:append_current_file_name_with_ext()

command! ChangeWordToCurrentFileName call s:change_word_to_current_file_name()
command! ChangeWordToCurrentFileNameWithExt call s:change_word_to_current_file_name_with_ext()

command! YankCurrentFileName call s:yank_current_file_name()
command! YankCurrentFullFilePath call s:yank_current_full_file_path()
command! YankCurrentFullDirPath call s:yank_current_full_dir_path()

command! ClearFileAndInsertMode call s:clear_file_and_insert_mode()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
