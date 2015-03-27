"" FILE: surround.vim
let s:cpo_save = &cpo
set cpo&vim

if !exists("g:surround_no_mappings") || ! g:surround_no_mappings
  nmap <C-s><C-s> ysiw
  xmap <C-s><C-s> S
endif

let &cpo = s:cpo_save
unlet s:cpo_save
