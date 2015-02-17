"" FILE: choosewin.vim
let s:cpo_save = &cpo
set cpo&vim

nmap <C-w>- <Plug>(choosewin)

let &cpo = s:cpo_save
unlet s:cpo_save
