"" FILE: pbcopy.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:pbcopy_buffer() abort
  execute ':w !pbcopy'
  redraw!
  echo 'Buffer copied to clipboard'
endf

fun! s:pbcopy_file_path() abort
  write

  let l:full_path = expand('%:p')
  let l:home = expand('~')

  if l:full_path =~# '^' . l:home
    let l:display_path = substitute(l:full_path, '^' . l:home, '~', '')
  else
    let l:display_path = l:full_path
  endif

  silent! execute '!echo -n ' . shellescape(l:display_path) . ' | pbcopy'
  redraw!
  echo 'Copied: ' . l:display_path
endf

command! PbcopyBuffer call s:pbcopy_buffer()
command! PbcopyFilePath call s:pbcopy_file_path()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
