"" FILE: config.bundle.vim
" neobundleで管理しているプラグインでafter/以下では動作しない設定を記述する

"" colorscheme
colorscheme desert   " desert
set background=light

"" neocomplete
let g:neocomplete#enable_at_startup = 1 " neocompleteを起動時に有効化

"" QuickBuf
let g:qb_hotkey = '__'  " `__`で起動

"" yankring
let g:yankring_history_dir      = "$HOME/.cache/yankring/" " yankring_historyの保存先を指定
let g:yankring_max_history      = 30                       " 記録する最大数
let g:yankring_max_display      = 30                       " YRShowの最大表示数
let g:yankring_ignore_duplicate = 0                        " yankring_historyの重複テキストを保存しない

"" syntastic
let g:syntastic_auto_loc_list = 1                " エラーがあったら自動でロケーションリストを開く
let g:syntastic_error_symbol = '✗'               " errorのマーカー
let g:syntastic_warning_symbol = '⚠'             " warningのマーカー
let g:syntastic_javascript_checkers = ['jshint'] " jsをチェックするツール指定
let g:syntastic_coffee_checkers = ['coffeelint'] " coffeeのチェックをするツール指定
let g:syntastic_mode_map = { 'mode': 'passive' }

"" ctrlp
let g:ctrlp_map = '<C-k>'                         " Start CtrlP
let g:ctrlp_match_window = 'min:10,max:'.&lines/2 " quickfixサイズ
let g:ctrlp_mruf_max = 100                        " 開いたファイル履歴保持数
let g:ctrlp_clear_cache_on_exit = 0               " 終了時にキャッシュをクリアしない
let g:ctrlp_max_depth = 30                        " ディレクトリ再帰検索深度
let g:ctrlp_open_new_file = 'r'                   " 新しいファイルをカレントウィンドウに開く
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
  \ 'PrtExpandDir()':       ['<TAB>','<C-i>'],
  \ 'AcceptSelection("e")': ['<C-l>','<CR>'],
  \ 'AcceptSelection("h")': ['<C-s>'],
  \ 'AcceptSelection("t")': ['<C-t>'],
  \ 'AcceptSelection("v")': ['<C-v>'],
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
let g:wildfire_fuel_map = '<C-l>'  " text-object拡大
let g:wildfire_water_map = '<C-h>' " text-object縮小
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
  \ 'is', 'as',
  \ 'ip', 'ap'
\ ]

"" auto-ctags
let g:auto_ctags = 0                                                                   " BufWritePostで自動実行しない
let g:auto_ctags_bin_path = "$HOME/local/bin/ctags"                                    " ctagsのbinパス
let g:auto_ctags_tags_name = '.tags'                                                   " tagsファイル名
let g:auto_ctags_tags_args = '--recurse --tag-relative --sort=yes --languages=sh,ruby' " ctags実行オプション
