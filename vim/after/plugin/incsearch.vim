"" FILE: incsearch.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

"" 検索単語ハイライト
hi Search ctermbg=Yellow
hi Search ctermfg=Red

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
