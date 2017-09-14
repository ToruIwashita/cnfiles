"" FILE: tab_relocator.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" shiftで移動後のカーソル画面位置
let g:tab_relocator_after_shift = 'zz'

noremap <C-w>! :<C-u>TabShift<CR>
noremap <C-w>m :<C-u>TabMove<SPACE>
noremap <C-w>T :<C-u>TabNewAtFirst<CR>
noremap <C-w><C-t> :<C-u>TabNewAtLast<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
