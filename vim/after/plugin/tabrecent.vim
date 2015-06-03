"" FILE: tabrecent.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-w>_ :<C-u>TabRecent<CR>
noremap <C-w><C-_> :<C-u>TabRecent<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
