"" FILE: funky.vim
let s:cpo_save = &cpo
set cpo&vim

" 移動後の画面位置
let g:ctrlp_funky_after_jump = 'zxzz'

function! s:ctrlp_funky_range() range
  let unnamed_register = @@
  silent normal gvy
  let selected_range = @@
  let @@ = unnamed_register

  if strlen(matchstr(selected_range,"^\\s*$"))
    return 0
  endif

  execute 'CtrlPFunky '.selected_range
endfunction

command! -range CtrlPFunkyRange call s:ctrlp_funky_range()

nnoremap <C-s><C-h> :<C-u>CtrlPFunky<CR>
nnoremap <C-s>h :<C-u>execute 'CtrlPFunky '.expand('<cword>')<CR>
vnoremap <silent> <C-s>h :<C-u>CtrlPFunkyRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
