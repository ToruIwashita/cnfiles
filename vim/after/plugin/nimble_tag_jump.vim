"" FILE: nimble_tag_jump.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" タグジャンプ後のカーソル画面位置
let g:nimble_tag_jump_after_jump = 'zz'

noremap <C-s><C-l> :<C-u>NimbleTjump<CR>
noremap <C-s>l :<C-u>NimbleTag<CR>
vnoremap <C-s><C-l> :<C-u>NimbleTjumpRange<CR>
vnoremap <C-s>l :<C-u>NimbleTagRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
