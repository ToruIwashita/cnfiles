""" neocomplete
let s:cpo_save = &cpo
set cpo&vim

" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 30
" シンタックスをキャッシュするときの最小文字長
let g:neocomplete#sources#syntax#min_keyword_length = 3
" 手動補完時に補完を行う入力数
let g:neocomplete#manual_completion_start_length = 2
" 補完候補検索時に大文字・小文字を区別する
let g:neocomplete#enable_ignore_case = 0
" 大文字が入力されるまで大文字小文字の区別を無視
let g:neocomplete#enable_smart_case = 1
"" オムニ補完の関数を呼び出しキーワードパターン設定(ruby用)
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" オムニ補完の関数を呼び出しキーワードパターン設定初期化
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" オムニ補完の関数を呼び出しキーワードパターン設定(ruby用)
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"" neocomplete key-mappings
" Ctr+Jで補完候補確定
inoremap <expr><C-j> neocomplete#close_popup()
" Ctr+Gで補完キャンセル&ポップアップを閉じる
inoremap <expr><C-g> neocomplete#cancel_popup()
" <TAB>で補完候補移動(下)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <TAB>で補完候補移動(上)
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

let &cpo = s:cpo_save
unlet s:cpo_save
