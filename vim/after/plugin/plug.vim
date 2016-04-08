"" FILE: plug.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w>I :<C-u>PlugInstall<CR>
nnoremap <C-w>U :<C-u>PlugUpdate<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
