"" FILE: fugitive.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w>gb :<C-u>Gblame<Cr>

let &cpo = s:cpo_save
unlet s:cpo_save
