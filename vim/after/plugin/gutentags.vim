"" FILE: gutentags.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:gutentags_toggle()
  GutentagsToggleEnabled
  echo 'gutentags_enabled: '.g:gutentags_enabled
endf

command! GutentagsToggle call s:gutentags_toggle()

nnoremap <C-t> :<C-u>GutentagsToggle<CR>
nnoremap <leader>ct :<C-u>GutentagsUpdate!<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
