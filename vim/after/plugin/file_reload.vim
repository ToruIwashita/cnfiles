"" FILE: file_reload.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap _ :<C-u>ReloadAndNotify File reloaded!<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
