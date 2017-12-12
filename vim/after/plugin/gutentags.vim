"" FILE: gutentags.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! gutentags#gutentags_enabled()
  return g:gutentags_enabled
endf

"" 以下のpluginに依存している
" lightline.vim
fun! s:gutentags_toggle()
  GutentagsToggleEnabled

  call lightline#update()

  if g:gutentags_enabled == 1
    echo 'GutentagsEnabled: true'
  else
    echo 'GutentagsEnabled: false'
  endif
endf

fun! s:create_tags()
  GutentagsUpdate!
  redraw!
  echo 'CreateTags'
endf

command! GutentagsToggle call s:gutentags_toggle()
command! CreateTags call s:create_tags()

nnoremap <C-t> :<C-u>GutentagsToggle<CR>
nnoremap <leader>ct :<C-u>CreateTags<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
