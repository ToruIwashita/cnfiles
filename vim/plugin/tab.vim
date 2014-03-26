"" FILE: tab.vim
let s:cpo_save = &cpo
set cpo&vim

noreabbrev t tabnew

let &cpo = s:cpo_save
unlet s:cpo_save
