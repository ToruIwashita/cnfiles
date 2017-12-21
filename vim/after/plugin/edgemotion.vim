"" FILE: edgemotion.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

map <silent> <C-w>n <Plug>(edgemotion-j)
map <silent> <C-w><C-n> <Plug>(edgemotion-j)
map <silent> <C-w>p <Plug>(edgemotion-k)
map <silent> <C-w><C-p> <Plug>(edgemotion-k)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
