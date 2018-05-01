"" FILE: remove_tailing_space.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

cnorea %R %RemoveTailingSpace
cnorea '<,'>R '<,'>RemoveTailingSpace

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
