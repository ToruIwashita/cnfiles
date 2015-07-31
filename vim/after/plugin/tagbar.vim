"" FILE: tagbar.vim
let s:cpo_save = &cpo
set cpo&vim

let g:tagbar_ctags_bin = '~/local/bin/ctags'
let g:tagbar_left = 1
let g:tagbar_type_ruby = {
  \ 'kinds': [
  \   'm:modules',
  \   'c:classes',
  \   'd:describes',
  \   'C:contexts',
  \   'f:methods',
  \   'F:singleton methods'
  \ ]
\ }

noremap <C-w>l :<C-u>TagbarToggle<CR>
noremap <C-w><C-l> :<C-u>TagbarToggle<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
