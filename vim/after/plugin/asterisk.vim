"" FILE: asterisk.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" *を押した時にカーソルポジションを固定する
let g:asterisk#keeppos = 1

map *  <Plug>(asterisk-gz*)
map #  <Plug>(asterisk-gz#)
map g* <Plug>(asterisk-z*)
map g# <Plug>(asterisk-z#)
map <leader>* <Plug>(asterisk-z*)
map <leader># <Plug>(asterisk-z#)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
