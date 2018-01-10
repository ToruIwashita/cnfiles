"" FILE: NERD_tree.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

noremap <C-w>w :<C-u>NERDTreeToggle<CR>

fun! s:nerd_tree_setting() abort
  " 水平・垂直分割でファイルを開くキーを入れ替える
  nnoremap <buffer> i :<C-u>call nerdtree#ui_glue#invokeKeyMap("s")<CR>
  nnoremap <buffer> gi :<C-u>call nerdtree#ui_glue#invokeKeyMap("gs")<CR>
  nnoremap <buffer> s :<C-u>call nerdtree#ui_glue#invokeKeyMap("i")<CR>
  nnoremap <buffer> gs :<C-u>call nerdtree#ui_glue#invokeKeyMap("gi")<CR>
endf

augroup local_nerd_tree
  autocmd!
  autocmd FileType nerdtree call s:nerd_tree_setting()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
