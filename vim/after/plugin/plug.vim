"" FILE: plug.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-w>I :<C-u>PlugInstall<CR>
nnoremap <C-w>U :<C-u>PlugUpdate<CR>
nnoremap <C-w>G :<C-u>PlugUpgrade<CR>
nnoremap <C-w>C :<C-u>PlugClean<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
