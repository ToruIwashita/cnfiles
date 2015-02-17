"" FILE: ag.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s> :<C-u>Ag<SPACE>
vnoremap <C-s> :<C-u>Ag<SPACE><C-r><C-w><SPACE>

let &cpo = s:cpo_save
unlet s:cpo_save
