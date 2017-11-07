"" FILE: asterisk.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" *を押した時にカーソルポジションを固定する
let g:asterisk#keeppos = 1

map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map <leader>* <Plug>(asterisk-gz*)
map <leader># <Plug>(asterisk-gz#)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
