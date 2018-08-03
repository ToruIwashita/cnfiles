"" FILE: ctrlp.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>mk :<C-u>CtrlPMemolist<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
