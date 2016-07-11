"" FILE: help.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

if &l:buftype !=# 'help'
  setlocal list tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=78

  if exists('+colorcolumn')
    setlocal colorcolumn=+1
  endif

  if has('conceal')
    setlocal conceallevel=0
  endif
endif

let &cpo = s:cpo_save
unlet s:cpo_save
