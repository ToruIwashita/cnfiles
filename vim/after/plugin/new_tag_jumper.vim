"" FILE: tag_assist.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-s><C-l> :<C-u>NewTjump<CR>
noremap <C-s>l :<C-u>NewTag<CR>
vnoremap <C-s><C-l> :<C-u>NewTjumpRange<CR>
vnoremap <C-s>l :<C-u>NewTagRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
