"" FILE: pbcopy.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:pbcopy_buffer() abort
  execute ':w !pbcopy'
endf

fun! s:pbcopy_file_path() abort
  write
  silent! execute '!echo -n % | pbcopy'
  edit!
endf

command! PbcopyBuffer call s:pbcopy_buffer()
command! PbcopyFilePath call s:pbcopy_file_path()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
