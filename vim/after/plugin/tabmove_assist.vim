"" FILE: tabmove_assist.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" shiftで移動後のカーソル画面位置
let g:tabmove_assist_after_shift = 'zz'

noremap <C-w>! :<C-u>TabShift<CR>
noremap <C-w>m :<C-u>TabMove<SPACE>

let &cpo = s:cpo_save
unlet s:cpo_save
