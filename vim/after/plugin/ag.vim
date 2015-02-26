"" FILE: ag.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:silver_search()
  let keyword = expand('<cword>')

  if empty(keyword)
    return 0
  endif

  tabnew
  execute 'Ag '.keyword
endfunction

function! s:silver_search_range() range
  let unnamed_register = @@
  silent normal gvy
  let selected_range = @@
  let @@ = unnamed_register

  if strlen(matchstr(selected_range,"^\\s*$"))
    return 0
  endif

  tabnew
  execute 'Ag '.selected_range
endfunction

command! SilverSearch call s:silver_search()
command! -range SilverSearchRange call s:silver_search_range()

nnoremap <C-s>s :<C-u>SilverSearch<CR>
vnoremap <C-s>s :<C-u>SilverSearchRange<CR>
cnorea A Ag

let &cpo = s:cpo_save
unlet s:cpo_save
