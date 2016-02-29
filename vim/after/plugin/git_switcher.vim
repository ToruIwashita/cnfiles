"" FILE: git_switcher.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w><C-i> :<C-u>GswSave<CR>
nnoremap <C-w><C-r> :<C-u>GswLoad<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
