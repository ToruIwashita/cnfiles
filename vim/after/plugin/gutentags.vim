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

fun! s:create_gutentags() abort
  GutentagsUpdate!
  redraw!
  echo 'CreateGutentags'
endf

" gutentags非依存だがctagsの生成なのでここに関数を作成
fun! s:create_tags() abort
  call job_start('bash -c "ctags &>/dev/null"')
  echo 'CreateTags'
endf

" gutentags非依存だがctagsの生成なのでここに関数を作成
fun! s:create_sbt_tags() abort
  call job_start('bash -c "sbt gen-ctags &>/dev/null"')
  echo 'CreateSbtTags'
endf

fun! s:confrim_to_enable_creating_gutentags() abort
  call system('bash -c "git rev-parse &>/dev/null"')

  if v:shell_error
    return 0
  endif

  if confirm('enable gutentags?', "&Yes\n&No", 0) == 1
    call s:gutentags_toggle()
  endif
endf

command! GutentagsToggle call s:gutentags_toggle()
command! CreateGutentags call s:create_gutentags()
command! CreateTags call s:create_tags()
command! CreateSbtTags call s:create_sbt_tags()

nnoremap <C-t> :<C-u>GutentagsToggle<CR>
nnoremap <leader>cg :<C-u>CreateGutentags<CR>
nnoremap <leader>ct :<C-u>CreateTags<CR>
nnoremap <leader>cs :<C-u>CreateSbtTags<CR>

augroup local_gutentags
  autocmd!
  autocmd VimEnter * nested if @% ==# '' | call s:confrim_to_enable_creating_gutentags() | endif
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
