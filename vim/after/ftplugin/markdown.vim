"" FILE: markdown.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:add_md_space()
  try
    :%s/\(^[^$].*[^  ]$\)/\1  /
    :%s/\(^ \{4}.*[^ ] \{2}$\)/\1  /
  catch
  endtry
endfunction

command! MdFormat :call s:add_md_space()
cnorea M MdFormat

let &cpo = s:cpo_save
unlet s:cpo_save
