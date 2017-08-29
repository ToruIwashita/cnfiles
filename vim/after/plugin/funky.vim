"" FILE: funky.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" 移動後の画面位置
let g:ctrlp_funky_after_jump = 'zxzz'
" vimのsessionをロードするとg:ctrlp_builtinsの値が2,つまりg:ctrlp_typesの値がデフォルトになった状態でs:idが算出されるのでプラグインが動かない
" ここで明示的に値を指定すると動く
let g:ctrlp_types = ['fil', 'buf']
let g:ctrlp_builtins = len(g:ctrlp_types) - 1

fun! s:ctrlp_funky_range() range
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
vnoremap <C-s><C-h> :<C-u>CtrlPFunkyRange<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
