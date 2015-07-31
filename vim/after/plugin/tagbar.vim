"" FILE: tagbar.vim
let s:cpo_save = &cpo
set cpo&vim

let g:tagbar_ctags_bin = '~/local/bin/ctags'
let g:tagbar_left = 1

noremap <C-w>l :<C-u>TagbarToggle<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
