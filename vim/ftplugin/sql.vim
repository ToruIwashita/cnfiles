"" FILE: sql.vim
if exists('b:did_cnfiles_sql_ftplugin')
  finish
endif
let b:did_cnfiles_sql_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

imap <buffer> =c COUNT(1)<SPACE>AS<SPACE>cnt
imap <buffer> =s SELECT<SPACE>*<ENTER>FROM<SPACE>
imap <buffer> =i <ENTER>INNER JOIN<SPACE>
imap <buffer> =l <ENTER>LEFT JOIN<SPACE>
imap <buffer> =w <ENTER>WHERE<SPACE>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
