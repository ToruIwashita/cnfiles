"" FILE: file_reload_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" <NUL>は<C-Space>を表す
noremap <NUL> :<C-u>ReloadAndNotify File reloaded!<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
