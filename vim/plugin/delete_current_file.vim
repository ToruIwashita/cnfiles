"" FILE: delete_current_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:delete_current_file()
  if confirm("delete '".expand('%:t')."'?", "&Yes\n&No", 0) != 1
    return 1
  endif

  call delete(expand('%')) | bdelete!
endf

fun! s:buffer_delete_current_file()
  bdelete!
endf

command! DeleteCurrentFile call s:delete_current_file()
command! BufferDeleteCurrentFile call s:buffer_delete_current_file()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
