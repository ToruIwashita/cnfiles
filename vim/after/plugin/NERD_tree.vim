"" FILE: NERD_tree.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

noremap <C-w>w :<C-u>NERDTreeToggle<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
