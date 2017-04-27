"" FILE: dot.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:WMGraphviz_output = 'svg'

nnoremap <leader>g :<C-u>GraphvizShow<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
