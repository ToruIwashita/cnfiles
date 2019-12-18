"" FILE: gitmessenger.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" カーソル移動でウィンドウを閉じる
let g:git_messenger_close_on_cursor_moved = v:false
" コミットの内容をすべて表示
let g:git_messenger_include_diff = 'all'
" コミット表示用ウィンドウが開いたら移動
let g:git_messenger_always_into_popup = v:true
" デフォルトのキーマップを無効化
let g:git_messenger_no_default_mappings = v:true

nmap <C-g>, <Plug>(git-messenger)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
