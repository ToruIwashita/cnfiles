"" FILE: auto_ctags.vim
let s:cpo_save = &cpo
set cpo&vim

cnorea C :<C-u>Ctags

let &cpo = s:cpo_save
unlet s:cpo_save
