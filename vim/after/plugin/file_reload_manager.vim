"" FILE: file_reload_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" <C-@>でファイルリロード（<C-@>は<C-Space>も表す）
noremap <C-@> :<C-u>ReloadAndNotify File reloaded!<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
