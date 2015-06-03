"" FILE: tag_tnjump.vim
let s:cpo_save = &cpo
set cpo&vim

" タグジャンプ後のカーソル画面位置
let g:tag_tnjump_after_jump = 'zt'

noremap <C-s><C-l> :<C-u>NewTjump<CR>
noremap <C-s>l :<C-u>NewTag<CR>
vnoremap <C-s><C-l> :<C-u>NewTjumpRange<CR>
vnoremap <C-s>l :<C-u>NewTagRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
