"" FILE: ctrlp.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <silent> <C-s><C-k> :<C-u>CtrlPBuffer<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
