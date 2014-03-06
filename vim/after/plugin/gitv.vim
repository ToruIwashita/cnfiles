"" FILE: gitv.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w>gv :Gitv --all<Cr>
nnoremap <C-w>gV :Gitv! --all<Cr>

let &cpo = s:cpo_save
unlet s:cpo_save
