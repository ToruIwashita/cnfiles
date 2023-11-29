"" FILE: sql.vim
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

map! <buffer> =c count(1) AS cnt
map! <buffer> =s SELECT<SPACE>*<ENTER>FROM<SPACE>
map! <buffer> =i <ENTER>INNER JOIN<SPACE>
map! <buffer> =l <ENTER>LEFT JOIN<SPACE>
map! <buffer> =w <ENTER>WHERE<SPACE>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
