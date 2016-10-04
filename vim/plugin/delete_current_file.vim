"" FILE: delete_current_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

fun! s:delete_current_file()
  if confirm("delete '".expand('%:t')."'?", "&Yes\n&No", 0) != 1
    return 1
  endif

  call delete(expand('%')) | bdelete!
endf

command! DeleteCurrentFile call s:delete_current_file()

let &cpo = s:cpo_save
unlet s:cpo_save
