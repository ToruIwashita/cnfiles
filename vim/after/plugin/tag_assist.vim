"" FILE: tag_assist.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-s>h :<C-u>NewTag<CR>
noremap <C-s>l :<C-u>NewTjump<CR>
vnoremap <C-s>h :<C-u>NewTagRange<CR>
vnoremap <C-s>l :<C-u>NewTjumpRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
