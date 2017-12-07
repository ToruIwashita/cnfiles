"" FILE: scala.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" ctagsの設定は~/.ctagsに任せるので無効化する
let g:scala_use_builtin_tagbar_defs = 0

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
