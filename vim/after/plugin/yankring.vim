"" FILE: yankring.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-w>P :<C-u>YRShow<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
