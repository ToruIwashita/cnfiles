"" FILE: neosnippet.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" キャッシュディレクトリ
let g:neosnippet#data_directory = g:cache_dir_path.'/vim/neosnippet'
" snipmate用に作られたsnippetsとの互換性を上げる
let g:neosnippet#enable_snipmate_compatibility = 1
" neosnippetの読み込みを無効化
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
" snippetsを読み込み
let g:neosnippet#snippets_directory = g:vim_dir_path.'/plugged/vim-snippets/snippets'

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
