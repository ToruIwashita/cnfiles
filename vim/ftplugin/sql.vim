"" FILE: sql.vim
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

ab <buffer> =c COUNT(1) AS count
map! <buffer> =sql SELECT<ENTER>  *<ENTER><BS>FROM<ENTER>WHERE<SPACE>(<ENTER>)<ESC>2kA<SPACE>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
