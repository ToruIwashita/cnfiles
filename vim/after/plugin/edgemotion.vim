"" FILE: edgemotion.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

map <C-e> <NOP>
map <C-e>] <Plug>(edgemotion-j)
map <C-e><C-]> <Plug>(edgemotion-j)
map <C-e>] <Plug>(edgemotion-k)
map <C-e><C-[> <Plug>(edgemotion-k)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
