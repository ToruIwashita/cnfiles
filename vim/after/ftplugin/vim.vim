"" FILE: vim.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

ab <buffer> =d Debugger

let &cpo = s:cpo_save
unlet s:cpo_save
