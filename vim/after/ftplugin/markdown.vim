"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" mdはテキストの最大幅無し
setlocal textwidth=0

let g:add_md_space_enabled = 1

fun! markdown#add_md_space_enabeld() abort
  return g:add_md_space_enabled
endf

" lightline.vim依存のコード
fun! s:add_md_space_toggle() abort
  if g:add_md_space_enabled
    let g:add_md_space_enabled = 0
  else
    let g:add_md_space_enabled = 1
  endif

  call lightline#update()
endf

fun! s:add_md_space() abort
  if !g:add_md_space_enabled
    return 1
  endif

  execute 'mark Z'

  silent! execute '%s/\(^ \{4,}[^-]*[^ ]$\)/\1    /'
  silent! execute '%s/\(^[^$].*[^ ]$\)/\1  /'

  silent! normal! `Z
  execute 'delmarks Z'
endfunction

fun! s:add_md_space_range() abort range
  if !g:add_md_space_enabled
    return 1
  endif

  silent! execute a:firstline.','.a:lastline.'s/\(^ \{4,}[^-]*[^ ]$\)/\1    /'
  silent! execute a:firstline.','.a:lastline.'s/\(^[^$].*[^ ]$\)/\1  /'
endfunction

augroup local_markdown
  autocmd!
  autocmd BufWritePre *.md call s:add_md_space()
augroup END

command! AddMdSpaceToggle call s:add_md_space_toggle()
command! -range MdFormat :<line1>,<line2>call s:add_md_space_range()

nnoremap <C-@> :<C-u>AddMdSpaceToggle<CR>

cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
