"" FILE: dot.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:WMGraphviz_output = 'svg'

nnoremap <leader>p :<C-u>GraphvizCompile<CR>:<C-u>GraphvizShow<CR><CR>

let &cpo = s:cpo_save
unlet s:cpo_save
