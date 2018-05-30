"" FILE: neocomplete.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" キャッシュディレクトリ
let g:neocomplete#data_directory = g:cache_dir_path.'/vim/neocomplete'
" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 30
" 補完候補検索時に大文字・小文字を区別する
let g:neocomplete#enable_ignore_case = 0
" 大文字が入力されるまで大文字小文字の区別を無視設定無効
let g:neocomplete#enable_smart_case = 0
" 自動補完を開始する入力数
let g:neocomplete#auto_completion_start_length = 1
" 手動補完を開始する入力数
let g:neocomplete#manual_completion_start_length = 0
" シンタックスをキャッシュするときの最小文字長
let g:neocomplete#min_keyword_length = 2

"" オムニ補完の関数を呼び出しキーワードパターン設定(ruby用)
augroup local_neocomplete
  autocmd!
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END

" オムニ補完の関数を呼び出しキーワードパターン設定初期化
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" オムニ補完の関数を呼び出しキーワードパターン設定(ruby用)
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

"" neocomplete key-mappings
" Ctr+Gで補完キャンセル&ポップアップを閉じる
inoremap <expr> <C-g> neocomplete#cancel_popup()
" <TAB>で補完候補移動(下)
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <TAB>で補完候補移動(上)
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"" 補完ポップアップメニュー色設定
" 補完メニューの全てのアイテム
hi Pmenu      ctermbg=75
" 選択しているアイテム
hi PmenuSel   ctermbg=45
" スクロールバー
hi PmenuSbar  ctermbg=25
" スクロールバーのレバー
hi PmenuThumb ctermbg=85

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
