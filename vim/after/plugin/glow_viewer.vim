"" FILE: glow_viewer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>j :<C-u>GlowView<CR>
nnoremap <C-s><C-j> :<C-u>GlowView<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
