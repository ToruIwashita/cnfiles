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
let g:yankring_history_dir = '~/.vim/.tmp/'
" 記録する最大数
let g:yankring_max_history = 30
" YRShowの最大表示数
let g:yankring_max_display = 30
" yankring_historyの重複テキストを保存しない
let g:yankring_ignore_duplicate = 0

""" wildfire.vim
" text-object拡大
let g:wildfire_fuel_map = "<C-l>"
" text-object縮小
let g:wildfire_water_map = "<C-h>"
" text-object対象
let g:wildfire_objects = [
  \ "i'", "a'",
  \ 'i"', 'a"',
  \ 'i)', 'a)',
  \ 'i]', 'a]',
  \ 'i}', 'a}',
  \ 'i>', 'a>',
  \ 'it', 'at',
  \ 'ip' 
\ ]
