"" FILE: edgemotion.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

map <C-w>n <Plug>(edgemotion-j)
map <C-w><C-n> <Plug>(edgemotion-j)
map <C-w>p <Plug>(edgemotion-k)
map <C-w><C-p> <Plug>(edgemotion-k)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
