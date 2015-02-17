"" FILE: tab_assist.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-w>! :<C-u>TShift<CR>
noremap <C-w>m :<C-u>TMove<SPACE>

let &cpo = s:cpo_save
unlet s:cpo_save
