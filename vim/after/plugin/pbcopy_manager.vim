"" FILE: pbcopy_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap <C-s>b :<C-u>wa<CR>:CopyBufferToClipboard<CR>
noremap <C-s><C-b> :<C-u>wa<CR>:CopyBufferToClipboard<CR>
noremap <C-s><C-y> :<C-u>CopyFilePathToClipboard <CR>

vnoremap <C-y> :<C-u>CopySelectionWithPathToClipboard<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
