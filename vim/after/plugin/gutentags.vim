"" FILE: gutentags.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! gutentags#gutentags_enabled() abort
  return g:gutentags_enabled
endf

" lightline.vim依存のコード
fun! s:gutentags_toggle() abort
  GutentagsToggleEnabled

  call lightline#update()
endf

fun! s:create_tags() abort
  GutentagsUpdate!
  redraw!
  echo 'CreateTags'
endf

" gutentags非依存だがctagsの生成なのでここに関数を作成
fun! s:create_sbt_tags() abort
  call job_start('bash -c "sbt gen-ctags >/dev/null 2>&1"')
  echo 'CreateSbtTags'
endf

command! GutentagsToggle call s:gutentags_toggle()
command! CreateTags call s:create_tags()
command! CreateSbtTags call s:create_sbt_tags()

nnoremap <C-t> :<C-u>GutentagsToggle<CR>
nnoremap <leader>ct :<C-u>CreateTags<CR>
nnoremap <leader>cs :<C-u>CreateSbtTags<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
