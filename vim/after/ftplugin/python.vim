"" FILE: python.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

ab <buffer> =p import pry; pry()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
