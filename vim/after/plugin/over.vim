"" FILE: over.vim
let s:cpo_save = &cpo
set cpo&vim

cnorea O :<C-u>OverCommandLine
cnorea '<,'>O '<,'>OverCommandLine

let &cpo = s:cpo_save
unlet s:cpo_save
