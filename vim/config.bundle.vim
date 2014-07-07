"" FILE: config.bundle.vim
" neobundleで管理しているプラグインでfunction,autocmd,mapなどを含まずに設定できる(もしくはafter/以下では動作しない設定)を記述する

"" colorscheme
" desert
colorscheme desert
set background=light

"" neocomplete
let g:neocomplete#enable_at_startup = 1  " neocompleteを起動時に有効化

"" NERD_tree
noremap <C-w><C-w> :<C-u>NERDTreeToggle<CR>

"" QuickBuf
let g:qb_hotkey = "__"  " `__`で起動

"" Align
let g:Align_xstrlen = 3      " 全角文字のハンドリング
let g:DrChipTopLvlMenu = ''  " GUIのメニュー表示(不要な場合は空文字を入れる)
" コマンドラインモードabbreviate
cnorea A Align
cnorea '<,'>A '<,'>Align
vnoremap <CR> :<C-u>'<,'>Align<SPACE>

"" ag
" コマンドラインモードabbreviate
nnoremap <C-s> :<C-u>Ag<SPACE>
vnoremap <C-s> :<C-u>Ag<SPACE><C-r><C-w><SPACE>

"" yankring
let g:yankring_history_dir = '~/.cache/yankring/'  " yankring_historyの保存先を指定
let g:yankring_max_history = 30                    " 記録する最大数
let g:yankring_max_display = 30                    " YRShowの最大表示数
let g:yankring_ignore_duplicate = 0                " yankring_historyの重複テキストを保存しない
" ヤンク履歴表示
noremap <C-w>P :<C-u>YRShow<CR>

"" vim-choosewin
nmap <C-w>- <Plug>(choosewin)

"" ctrlp
let g:ctrlp_map = '<C-k>'                         " Start CtrlP
let g:ctrlp_match_window = 'min:10,max:'.&lines/2 " quickfixサイズ
let g:ctrlp_mruf_max = 500                        " 開いたファイル履歴保持数
let g:ctrlp_clear_cache_on_exit = 0               " 終了時にキャッシュをクリアしない
let g:ctrlp_max_depth = 40                        " ディレクトリ再帰検索深度
let g:ctrlp_open_new_file = 'r'                   " 新しいファイルをカレントウィンドウに開く
" CtrlPキーマッピング
let g:ctrlp_prompt_mappings = {
  \ 'ToggleRegex()':        ['<C-_>'],
  \ 'ToggleByFname()':      ['<C-@>'],
  \ 'PrtBS()':              ['<C-h>','<BS>'],
  \ 'PrtDelete()':          ['<C-d>'],
  \ 'PrtDeleteWord()':      ['<C-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtCurStart()':        ['<C-a>'],
  \ 'PrtCurEnd()':          ['<C-e>'],
  \ 'PrtCurLeft()':         ['<C-b>'],
  \ 'PrtCurRight()':        ['<C-f>'],
  \ 'PrtSelectMove("j")':   ['<C-j>'],
  \ 'PrtSelectMove("k")':   ['<C-k>'],
  \ 'PrtHistory(-1)':       ['<C-n>'],
  \ 'PrtHistory(1)':        ['<C-p>'],
  \ 'ToggleFocus()':        ['<S-TAB>'],
  \ 'PrtExpandDir()':       ['<TAB>','<C-i>'],
  \ 'AcceptSelection("e")': ['<C-l>','<C-o>','<CR>'],
  \ 'AcceptSelection("h")': ['<C-s>'],
  \ 'AcceptSelection("t")': ['<C-t>'],
  \ 'AcceptSelection("v")': ['<C-v>'],
  \ 'ToggleType(1)':        ['<NOP>'],
  \ 'ToggleType(-1)':       ['<NOP>'],
  \ 'PrtInsert()':          ['<NOP>'],
  \ 'PrtDeleteEnt()':       ['<NOP>'],
  \ 'CreateNewFile()':      ['<NOP>'],
  \ 'MarkToOpen()':         ['<NOP>'],
  \ 'OpenMulti()':          ['<NOP>'],
  \ 'PrtSelectMove("t")':   ['<NOP>'],
  \ 'PrtSelectMove("b")':   ['<NOP>'],
  \ 'PrtSelectMove("u")':   ['<NOP>'],
  \ 'PrtSelectMove("d")':   ['<NOP>'],
  \ 'PrtClearCache()':      ['<C-r>'],
  \ 'PrtExit()':            ['<ESC>','<C-[>'],
  \ }

"" wildfire
let g:wildfire_fuel_map = '<C-l>'   " text-object拡大
let g:wildfire_water_map = '<C-h>'  " text-object縮小
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

"" auto-ctags
let g:auto_ctags = 0                                                                    " BufWritePostで自動実行しない
let g:auto_ctags_tags_name = '.tags'                                                    " tagsファイル名
let g:auto_ctags_tags_args = '--recurse --tag-relative --sort=yes --languages=sh,ruby'  " ctags実行オプション
" コマンドラインモードabbreviate
cnorea C Ctags
