"" FILE: fugitive.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w>gb :<C-u>Gblame<CR>
nnoremap <C-w>gd :<C-u>GDiff<CR>
nnoremap <C-w>gs :<C-u>GStatus<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
