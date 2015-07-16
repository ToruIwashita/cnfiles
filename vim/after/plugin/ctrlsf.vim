"" FILE: ctrlsf.vim
let s:cpo_save = &cpo
set cpo&vim

nmap <C-s>s <Plug>CtrlSFCwordPath<CR>
vmap <C-s>s <Plug>CtrlSFVwordExec
nmap <C-s>* <Plug>CtrlSFPwordPath<CR>
nnoremap <C-s><C-s> :<C-u>CtrlSFToggle<CR>
cnorea C :<C-u>CtrlSF

let &cpo = s:cpo_save
unlet s:cpo_save
