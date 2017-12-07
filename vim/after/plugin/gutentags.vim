"" FILE: gutentags.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:gutentags_toggle()
  GutentagsToggleEnabled
  echo 'gutentags_enabled: '.g:gutentags_enabled
endf

fun! s:create_tags()
  GutentagsUpdate!
  redraw!
  echo 'CreateTag'
endf

command! GutentagsToggle call s:gutentags_toggle()
command! CreateTag call s:create_tags()

nnoremap <C-t> :<C-u>GutentagsToggle<CR>
nnoremap <leader>ct :<C-u>CreateTag<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
