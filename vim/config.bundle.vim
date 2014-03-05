""" Vim-Tomorrow-Theme
colorscheme Tomorrow-Night-Bright

""" NERDTree open,close
noremap <C-w>_ :NERDTreeToggle<CR>
" 引数なしVim実行時にNERDTree
if has('vim_starting') && expand("%:p") == ""
  autocmd VimEnter * NERDTree
endif

""" neocomplete
" neocompleteを起動時に有効化
let g:neocomplete#enable_at_startup = 1
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

""" neosnippet key-mappings
" Ctr+Kでスニペット展開&ターゲット移動
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

""" QuickBuf
let g:qb_hotkey = "__"

""" lightline
" Gitブランチ表示などはデフォルト空文字
let g:lightline = {
  \ 'colorscheme': 'Tomorrow',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified':     'MyModified',
  \   'readonly':     'MyReadonly',
  \   'fugitive':     'MyFugitive',
  \   'filename':     'MyFilename',
  \   'fileformat':   'MyFileformat',
  \   'filetype':     'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode':         'MyMode'
  \ }
\ }
" component: MyModified
function! MyModified()
  if &filetype == 'help'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return ''
  endif
endfunction
" component: MyReadonly
function! MyReadonly()
  if &filetype == 'help'
    return ''
  elseif &readonly
    return 'RO'
  else
    return ''
  endif
endfunction
" component: MyFugitive
function! MyFugitive()
  let fname = expand("%:t")
  return (fname =~ 'NERD_tree' ? '' : exists("*fugitive#head") ? fugitive#head() != '' ? '* ' . fugitive#head() : '' : '')
endfunction
" component: MyFilename
function! MyFilename()
  let fname = expand("%:t")
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != fname ? fname =~ 'NERD_tree' ? 'NERDTree' : fname : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
" component: MyFileformat
function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
" component: MyFiletype
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
" component: MyFileencoding
function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
" component: MyMode
function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

""" visualstar
" visualstarで検索した後に移動しない
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

""" Align
" 全角文字のハンドリング
let g:Align_xstrlen = 3
" GUIのメニュー表示(不要な場合は空文字を入れる)
let g:DrChipTopLvlMenu = ''

""" yankring
" yankring_historyの保存先を指定
let g:yankring_history_dir = '~/.vim/.tmp/'
" 記録する最大数
let g:yankring_max_history = 30
" YRShowの最大表示数
let g:yankring_max_display = 30
" yankring_historyの重複テキストを保存しない
let g:yankring_ignore_duplicate = 0

""" fugitive
" vimでgit blame
nnoremap <C-w>gb :Gblame<Cr>

""" gitv
" vimでバッファのコミットログ閲覧
nnoremap <C-w>gv :Gitv --all<Cr>
nnoremap <C-w>gV :Gitv! --all<Cr>
