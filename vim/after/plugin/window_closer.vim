"" FILE: window_closer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

noremap <silent> <leader>l :<C-u>CloseRightWin<CR>
noremap <silent> <leader>h :<C-u>CloseLeftWin<CR>
noremap <silent> <leader><C-n> :<C-u>CloseDownWin<CR>
noremap <silent> <leader><C-p> :<C-u>CloseUpWin<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
