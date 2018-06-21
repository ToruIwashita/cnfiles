"" FILE: sql.vim
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

ab <buffer> =c COUNT(1) AS count
map! <buffer> =sql SELECT<ENTER>FROM<ENTER>WHERE (<ENTER>)<ESC>4ko  *<ESC>jA<SPACE>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
