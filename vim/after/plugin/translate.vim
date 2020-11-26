"" FILE: translate.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:translate_range() range
  let l:unnamed_register = @@
  silent normal! gvy
  let l:selected_range = @@
  let @@ = l:unnamed_register

  if strlen(matchstr(l:selected_range,"^\\s*$"))
    return 0
  endif

  execute 'Translate '.l:selected_range
endf

fun! s:translate_bang_range() range
  let l:unnamed_register = @@
  silent normal! gvy
  let l:selected_range = @@
  let @@ = l:unnamed_register

  if strlen(matchstr(l:selected_range,"^\\s*$"))
    return 0
  endif

  execute 'Translate! '.l:selected_range
endf

command! -range TranslateRange call s:translate_range()
command! -range TranslateBangRange call s:translate_bang_range()

nnoremap <C-s>, V:Translate<CR>
nnoremap <C-s>. V:Translate!<CR>
vnoremap <C-s>, :<C-u>TranslateRange<CR>
vnoremap <C-s>. :<C-u>TranslateBangRange<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
