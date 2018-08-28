"" FILE: tmux_send_keys.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap <C-x> :<C-u>wa<CR>:<C-u>TmuxCallPrevCommand<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
