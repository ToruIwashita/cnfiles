"" FILE: ctrlp-modified.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>k :<C-u>CtrlPModified<CR>
nnoremap <leader>k :<C-u>CtrlPBranch<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
