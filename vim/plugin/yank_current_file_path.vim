"" FILE: yank_current_file_path.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:yank_current_file_path() abort
  let @" = expand('%')
endf

command! YankCurrentFilePath call s:yank_current_file_path()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
