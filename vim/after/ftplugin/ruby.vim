"" FILE: ruby.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" !,?を区切り文字としない
setlocal iskeyword+=!,?

" RubyCursorIdentifier()とタブ移動のmap競合を解消
silent! nunmap <buffer> <C-w>]
silent! nunmap <buffer> <C-w><C-]>
" タグ移動のmapを解除
silent! nunmap <buffer> <C-]>

nnoremap <buffer> =d :<C-u>RemoveBindingPry<CR>
nnoremap <buffer> =t :<C-u>RemoveCurrentMarker<CR>

vnoremap <buffer> =y :<C-u>YankNamespace<CR>

iabbrev <buffer> =a , :aggregate_failures
iabbrev <buffer> =c context "current", :current do
iabbrev <buffer> =d binding.pry
iabbrev <buffer> =t , :current

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
