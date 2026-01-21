"" FILE: go.vim
set encoding=utf-8
scriptencoding utf-8

if exists('b:did_cnfiles_go_ftplugin')
  finish
endif
let b:did_cnfiles_go_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:godef_vsplit() abort
  execute 'vsplit'
  GoDef
endf

fun! s:godef_tabnew() abort
  let l:current_line_num = line('.')

  call s:godef_vsplit()

  tabedit %

  tabp
  hide
  tabn

  execute l:current_line_num
  execute 'normal! zz'
endf

command! -buffer GodefVsplit call s:godef_vsplit()
command! -buffer GodefTabnew call s:godef_tabnew()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
