"" FILE: pbcopy.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:pbcopy_buffer() abort
  execute ':w !pbcopy'
endf

command! PbcopyBuffer call s:pbcopy_buffer()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
