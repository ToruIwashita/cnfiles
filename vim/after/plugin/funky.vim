"" FILE: funky.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>fu :<C-u>CtrlPFunky<CR>
nnoremap <leader>fU :<C-u>execute 'CtrlPFunky '.expand('<cword>')<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
