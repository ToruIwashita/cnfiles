"" FILE: markdown.vim
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

function! g:add_md_space()
  try
    :%s/\(^[^$].*[^  ]$\)/\1  /
    :%s/\(^ \{4}.*[^ ] \{2}$\)/\1  /
  catch
  endtry
endfunction

command! AddMdSpace call g:add_md_space()

let &cpo = s:cpo_save
unlet s:cpo_save
