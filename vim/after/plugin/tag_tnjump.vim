"" FILE: tag_tnjump.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-s><C-l> :<C-u>NewTjump<CR>zt5<C-y>
noremap <C-s>l :<C-u>NewTag<CR>zt5<C-y>
vnoremap <C-s><C-l> :<C-u>NewTjumpRange<CR>zt5<C-y>
vnoremap <C-s>l :<C-u>NewTagRange<CR>zt5<C-y>

let &cpo = s:cpo_save
unlet s:cpo_save
