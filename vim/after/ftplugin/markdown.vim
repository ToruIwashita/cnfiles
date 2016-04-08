"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

function! s:add_md_space(line1,line2)
  silent! execute a:line1.','.a:line2.'s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute a:line1.','.a:line2.'s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'
endfunction

command! -range MdFormat call s:add_md_space(<line1>,<line2>)
cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

let &cpo = s:cpo_save
unlet s:cpo_save
