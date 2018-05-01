"" FILE: dot.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:WMGraphviz_output = 'svg'

nnoremap <C-s>v :<C-u>w<CR>:<C-u>GraphvizCompile<CR>:<C-u>GraphvizShow<CR><CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
