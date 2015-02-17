"" FILE: ag.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:silver_search()
  let keyword = expand('<cword>')
  tabnew
  execute 'Ag '.keyword
endfunction

function! s:silver_search_range() range
  let unnamed_register = @@
  silent normal gvy
  let selected_range = @@
  let @@ = unnamed_register
  tabnew
  execute 'Ag "'.selected_range.'"'
endfunction

command! SilverSearch call s:silver_search()
command! -range SilverSearchRange call s:silver_search_range()

nnoremap <C-s>s :<C-u>SilverSearch<CR>
vnoremap <C-s>s :<C-u>SilverSearchRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
