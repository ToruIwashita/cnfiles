"" FILE: config.bundle.vim
" neobundleで管理しているプラグインでfunction,autocmd,mapなどを含まずに設定できる(もしくはafter/以下では動作しない設定)を記述する

"" colorscheme
" desert
colorscheme desert
set background=light

"" neocomplete
" neocompleteを起動時に有効化
let g:neocomplete#enable_at_startup = 1

""" QuickBuf
" `__`で起動
let g:qb_hotkey = "__"

""" Align
" 全角文字のハンドリング
let g:Align_xstrlen = 3
" GUIのメニュー表示(不要な場合は空文字を入れる)
let g:DrChipTopLvlMenu = ''
" コマンドラインモードabbreviate
cnorea A Align
cnorea '<,'>A '<,'>Align

""" yankring
" yankring_historyの保存先を指定
let g:yankring_history_dir = '~/.cache/yankring/'
" 記録する最大数
let g:yankring_max_history = 30
" YRShowの最大表示数
let g:yankring_max_display = 30
" yankring_historyの重複テキストを保存しない
let g:yankring_ignore_duplicate = 0
" ヤンク履歴表示
noremap <C-w>P :<C-u>YRShow<CR>

""" ctrlp
" Start CtrlP
let g:ctrlp_map = '<C-s>'
" 表示行数を最大行数の1/3
let g:ctrlp_max_height = &lines/3
" 開いたファイル履歴保持数
let g:ctrlp_mruf_max = 500
" 終了時にキャッシュをクリアしない
let g:ctrlp_clear_cache_on_exit = 0
" ディレクトリ再帰検索深度
let g:ctrlp_max_depth = 40
" 新しいファイルをカレントウィンドウに開く
let g:ctrlp_open_new_file = 'r'
" CtrlPキーマッピング
let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<c-h>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtCurEnd()':          ['<c-e>'],
  \ 'PrtCurLeft()':         ['<c-b>'],
  \ 'PrtCurRight()':        ['<c-f>'],
  \ 'PrtSelectMove("j")':   ['<c-j>'],
  \ 'PrtSelectMove("k")':   ['<c-k>'],
  \ 'PrtHistory(-1)':       ['<c-n>'],
  \ 'PrtHistory(1)':        ['<c-p>'],
  \ 'AcceptSelection("e")': ['<cr>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ 'ToggleByFname()':      ['<c-d>'],
  \ 'PrtExit()':            ['<c-l>', '<esc>', '<c-c>'],
  \ 'ToggleFocus()':        ['<nop>'],
  \ 'PrtExpandDir()':       ['<nop>'],
  \ 'AcceptSelection("h")': ['<nop>'],
  \ 'AcceptSelection("t")': ['<nop>'],
  \ 'AcceptSelection("v")': ['<nop>'],
  \ 'ToggleType(1)':        ['<nop>'],
  \ 'ToggleType(-1)':       ['<nop>'],
  \ 'PrtInsert()':          ['<nop>'],
  \ 'PrtCurStart()':        ['<nop>'],
  \ 'PrtClearCache()':      ['<nop>'],
  \ 'PrtDeleteEnt()':       ['<nop>'],
  \ 'CreateNewFile()':      ['<nop>'],
  \ 'MarkToOpen()':         ['<nop>'],
  \ 'OpenMulti()':          ['<nop>'],
  \ 'PrtDelete()':          ['<nop>'],
  \ 'PrtSelectMove("t")':   ['<nop>'],
  \ 'PrtSelectMove("b")':   ['<nop>'],
  \ 'PrtSelectMove("u")':   ['<nop>'],
  \ 'PrtSelectMove("d")':   ['<nop>'],
  \ }

""" wildfire.vim
" text-object拡大
let g:wildfire_fuel_map = "<C-l>"
" text-object縮小
let g:wildfire_water_map = "<C-h>"
" text-object対象
let g:wildfire_objects = [
  \ "i'", "a'",
  \ 'i"', 'a"',
  \ 'i`', 'a`',
  \ 'i)', 'a)',
  \ 'i]', 'a]',
  \ 'i}', 'a}',
  \ 'i>', 'a>',
  \ 'it', 'at',
  \ 'ip' 
\ ]
