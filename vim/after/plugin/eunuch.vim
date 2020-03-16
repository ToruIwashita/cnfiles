"" FILE: eunuch.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:delete_current_file()
  if confirm("delete '".expand('%:t')."'?", "&Yes\n&No", 0) != 1
    return 1
  endif

  Delete
endf

fun! s:buffer_delete_current_file()
  bdelete!
endf

command! DeleteCurrentFile call s:delete_current_file()
command! BufferDeleteCurrentFile call s:buffer_delete_current_file()

nnoremap <C-s><C-m> :<C-u>Move<SPACE><C-r>=expand('%:p')<CR>
nnoremap <C-s><C-d> :<C-u>Mkdir<SPACE><C-r>=expand('%:p:h')<CR>
nnoremap <leader>D :<C-u>DeleteCurrentFile<CR>
nnoremap <leader>d :<C-u>BufferDeleteCurrentFile<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
