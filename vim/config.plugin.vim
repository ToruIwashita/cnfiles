"" FILE: config.plugin.vim
set encoding=utf-8
scriptencoding utf-8
"" vim-plugで管理しているプラグインでafter/以下では動作しない設定を記述する

"" colorscheme
colorscheme desert
set background=dark

"" neocomplete
let g:neocomplete#enable_at_startup = 1  " neocompleteを起動時に有効化

"" ale(after/ にも設定あり)
let g:ale_sign_column_always = 1                          " マーカー用のカラムを常に表示
let g:ale_lint_on_save = 1                                " save 時にシンタックスチェック
let g:ale_lint_on_enter = 1                               " ファイルオープン時にチェックする
let g:ale_lint_on_text_changed = 'always'                 " 自動コードチェック
let g:ale_set_loclist = 0                                 " loclist にエラー表示を無効
let g:ale_set_quickfix = 1                                " quickfix にエラー表示を有効
let g:ale_open_list = 1                                   " loclist / quickfix を常に表示
let g:ale_keep_list_window_open = 1                       " loclist / quickfix を常に表示
let g:ale_sign_error = '✗'                                " error マーカー
let g:ale_sign_warning = '⚠'                              " warning マーカー
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '']        " statusline 表示フォーマット
let g:ale_echo_msg_error_str = '✗'                        " statusline メッセージ error マーカー
let g:ale_echo_msg_warning_str = '⚠'                      " statusline メッセージ warning マーカー
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'  " statusline メッセージフォーマット
" linter 設定
let g:ale_linters = {
  \ 'ruby':       ['ruby'],
  \ 'javascript': ['jshint']
\ }

"" ctrlp(after/ にも設定あり)
let g:ctrlp_map = '<C-k>'                            " Start CtrlP
let g:ctrlp_match_window = 'min:10,max:'.&lines/3    " quickfixサイズ
let g:ctrlp_mruf_max = 100                           " 開いたファイル履歴保持数
let g:ctrlp_clear_cache_on_exit = 0                  " 終了時にキャッシュをクリアしない
let g:ctrlp_max_depth = 15                           " ディレクトリ再帰検索深度
let g:ctrlp_max_files = 25000                        " スキャンファイルの初期値
let g:ctrlp_open_new_file = 'r'                      " 新しいファイルをカレントウィンドウに開く
let g:ctrlp_open_multiple_files = 'jt'               " 複数ファイルを開く時新しいタブで開き,全て開き終わった後1つ目に移動する
let g:ctrlp_cache_dir = cache_dir_path.'/vim/ctrlp'  " キャッシュディレクトリ
let g:ctrlp_types = ['fil', 'buf']                   " 使用するモード指定(WIP)
" CtrlPキーマッピング
let g:ctrlp_prompt_mappings = {
  \ 'ToggleRegex()':        ['<C-_>'],
  \ 'ToggleByFname()':      ['<C-^>'],
  \ 'ToggleFocus()':        ['<S-TAB>'],
  \ 'ToggleType(1)':        ['<NOP>'],
  \ 'ToggleType(-1)':       ['<C-@>'],
  \ 'PrtBS()':              ['<C-h>','<BS>'],
  \ 'PrtDelete()':          ['<C-d>'],
  \ 'PrtDeleteWord()':      ['<C-w>'],
  \ 'PrtClear()':           ['<C-u>'],
  \ 'PrtCurStart()':        ['<C-a>'],
  \ 'PrtCurEnd()':          ['<C-e>'],
  \ 'PrtCurLeft()':         ['<C-b>'],
  \ 'PrtCurRight()':        ['<C-f>'],
  \ 'PrtSelectMove("j")':   ['<C-j>'],
  \ 'PrtSelectMove("k")':   ['<C-k>'],
  \ 'PrtHistory(-1)':       ['<C-n>'],
  \ 'PrtHistory(1)':        ['<C-p>'],
  \ 'PrtExpandDir()':       ['<NOP>'],
  \ 'AcceptSelection("e")': ['<C-l>','<CR>'],
  \ 'AcceptSelection("h")': ['<C-s>'],
  \ 'AcceptSelection("t")': ['<C-t>'],
  \ 'AcceptSelection("v")': ['<C-i>'],
  \ 'OpenMulti()':          ['<C-o>'],
  \ 'MarkToOpen()':         ['<C-]>'],
  \ 'PrtInsert()':          ['<NOP>'],
  \ 'PrtDeleteEnt()':       ['<NOP>'],
  \ 'CreateNewFile()':      ['<NOP>'],
  \ 'PrtSelectMove("t")':   ['<NOP>'],
  \ 'PrtSelectMove("b")':   ['<NOP>'],
  \ 'PrtSelectMove("u")':   ['<NOP>'],
  \ 'PrtSelectMove("d")':   ['<NOP>'],
  \ 'PrtClearCache()':      ['<C-r>'],
  \ 'PrtExit()':            ['<ESC>','<C-[>']
\ }

"" wildfire
let g:wildfire_fuel_map = '<C-l>'   " text-object拡大
let g:wildfire_water_map = '<C-h>'  " text-object縮小
"" wildfire,vim-textobj-user
" text-object対象
let g:wildfire_objects = [
  \ 'iW',
  \ "i'", "a'",
  \ 'i"', 'a"',
  \ 'i`', 'a`',
  \ 'i)', 'a)',
  \ 'i]', 'a]',
  \ 'i}', 'a}',
  \ 'i>', 'a>',
  \ 'it', 'at',
  \ 'il', 'al',
  \ 'ii', 'ai',
  \ 'is', 'as',
  \ 'ip', 'ap'
\ ]

"" auto-ctags(after/ にも設定あり)
let g:auto_ctags = 0                                     " BufWritePostで自動実行しない
let g:auto_ctags_bin_path = local_dir_path.'/bin/ctags'  " ctagsのbinパス
let g:auto_ctags_tags_name = '.tags'                     " tagsファイル名
let g:auto_ctags_tags_args = ''                          " ctags実行オプションは.ctagsで設定する

"" yankround(after/ にも設定あり)
let g:yankround_dir = cache_dir_path.'/vim/yankround'
let g:yankround_max_history = 30

"" terraform.vim
let g:terraform_fmt_on_save = 1
