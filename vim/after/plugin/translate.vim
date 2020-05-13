"" FILE: translate.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

xmap <C-s>. <Plug>(VTranslateBang)
xmap <C-s>/ <Plug>(VTranslate)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
