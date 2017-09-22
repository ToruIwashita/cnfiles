"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:add_md_space()
  execute 'mark Z'

  silent! execute '%s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute '%s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'

  normal! `Z
  execute 'delmarks Z'
endfunction

function! s:add_md_space_range(line1,line2)
  silent! execute a:line1.','.a:line2.'s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute a:line1.','.a:line2.'s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'
endfunction

augroup local_markdown
  autocmd!
  autocmd BufWritePre *.md call s:add_md_space()
augroup END

command! -range MdFormat call s:add_md_space_range(<line1>, <line2>)
cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
