"" FILE: committia.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:committia_use_singlecolumn = 'always'

let &cpo = s:cpo_save
unlet s:cpo_save
