"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

function! s:add_md_space()
  silent! execute '%s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute '%s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'
endfunction

function! s:add_md_space_range(line1,line2)
  silent! execute a:line1.','.a:line2.'s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute a:line1.','.a:line2.'s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'
endfunction

augroup local_markdown
  autocmd!
  autocmd BufWritePre * call s:add_md_space()
augroup END

command! -range MdFormat call s:add_md_space_range(<line1>, <line2>)
cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

let &cpo = s:cpo_save
unlet s:cpo_save
