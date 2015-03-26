"" FILE: ctrlp.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>k :<C-u>CtrlPTag<CR>
nnoremap <C-s><C-k> :<C-u>CtrlPTag<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
