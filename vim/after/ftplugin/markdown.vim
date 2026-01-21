"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" markdownはテキストの最大幅無し
setlocal textwidth=0
" オートインデント時の空白文字数(pluginで書き換えられてしまうため再設定)
setlocal shiftwidth=2
" <TAB>を含むファイルを開いた際,<TAB>を何文字の空白に変換するか(pluginで書き換えられてしまうため再設定)
setlocal tabstop=2
" キーボードで<TAB>を入力した際,<TAB>を何文字の空白に変換するか(pluginで書き換えられてしまうため再設定)
setlocal softtabstop=2

nnoremap _ :<C-u>AddMdSpaceToggle<CR>
nnoremap <C-_> :<C-u>AddMdSpaceToggle<CR>

vnoremap <Leader>fr :<C-u>'<,'>WrapWithFence ruby<CR>
vnoremap <Leader>fb :<C-u>'<,'>WrapWithFence bash<CR>
vnoremap <Leader>fs :<C-u>'<,'>WrapWithFence sql<CR>
vnoremap <Leader>fp :<C-u>'<,'>WrapWithFence plantuml<CR>
vnoremap <Leader>ff :<C-u>'<,'>WrapWithFence<CR>

cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

iabbrev <buffer> =b <br/>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
