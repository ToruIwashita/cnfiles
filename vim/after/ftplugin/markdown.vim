"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" mdはテキストの最大幅無し
setlocal textwidth=0

function! s:add_md_space()
  execute 'mark Z'

  silent! execute '%s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute '%s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'

  silent! normal! `Z
  execute 'delmarks Z'
endfunction

function! s:add_md_space_range() range
  silent! execute a:firstline.','.a:lastline.'s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute a:firstline.','.a:lastline.'s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'
endfunction

augroup local_markdown
  autocmd!
  autocmd BufWritePre *.md call s:add_md_space()
augroup END

command! -range MdFormat :<line1>,<line2>call s:add_md_space_range()

cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
