"" FILE: translate.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:translate_source = 'ja'
let g:translate_target = 'en'

xmap <C-s>. <Plug>(VTranslate)
xmap <C-s>/ <Plug>(VTranslateBang)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
