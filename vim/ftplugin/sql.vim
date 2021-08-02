"" FILE: sql.vim
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

ab <buffer> =c COUNT(1) AS count
map! <buffer> =s SELECT<ENTER><SPACE><SPACE>*<ENTER><BS>FROM<ENTER><SPACE><SPACE>
map! <buffer> =i <BS>INNER JOIN<ENTER><SPACE><SPACE>
map! <buffer> =l <BS>LEFT JOIN<ENTER><SPACE><SPACE>
map! <buffer> =o <BS>ON<ENTER><SPACE><SPACE>
map! <buffer> =w <BS>WHERE<ENTER><SPACE><SPACE>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
