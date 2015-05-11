"" FILE: sql.vim
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

ab <buffer> =c COUNT(1) AS count
map! <buffer> =sql SELECT<ENTER>FROM<ENTER>WHERE (<ENTER><ENTER>)<ESC>4ko  *<ESC>jA<SPACE>

let &cpo = s:cpo_save
unlet s:cpo_save
