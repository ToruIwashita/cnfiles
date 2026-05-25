"" FILE: html.vim

set encoding=utf-8
scriptencoding utf-8

if exists('b:did_cnfiles_html_ftplugin')
  finish
endif
let b:did_cnfiles_html_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:open_in_browser() abort
  let l:filepath = expand('%:p')

  if empty(l:filepath)
    echohl WarningMsg | echo 'No file path: please save the file first' | echohl None
    return
  endif

  if !filereadable(l:filepath)
    echohl WarningMsg | echo 'File not found: ' . l:filepath | echohl None
    return
  endif

  silent execute '!open ' . shellescape(l:filepath)
  redraw!

  echo 'Open in browser: ' . l:filepath
endf

command! -buffer OpenInBrowser call s:open_in_browser()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
