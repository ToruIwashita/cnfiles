"" FILE: plantuml-previewer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" 0000-00-00-tmp.pngを削除する
augroup local_plantuml_previewer
  autocmd!
  autocmd VimLeave * if filereadable(expand('0000-00-00-tmp.svg')) | call delete(expand('0000-00-00-tmp.svg')) | endif
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
