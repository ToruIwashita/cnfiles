"" FILE: dot.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:WMGraphviz_output = 'png'

nnoremap <C-s>v :<C-u>w<CR>:GraphvizCompile<CR>:GraphvizShow<CR>:redraw!<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
