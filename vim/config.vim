"" FILE: config.vim
set encoding=utf-8
scriptencoding utf-8

"" Vimの基本的な設定を記述

"" leader
let g:mapleader = ','

"" シンタックスハイライト
syntax on
"" 補完設定
set wildmenu
set wildmode=full
" `wildchar`:ワイルドカード展開に使用する文字(補完開始)
" `wildcharm`:マクロでも使えるワイルドカード展開に使用する文字
" 以下の設定によりコマンドラインモード(cnoremap)で元のマッピングが機能するようになる
let &wildcharm = &wildchar
syntax sync minlines=500 maxlines=1000  " シンタックスハイライトの開始/終了タグ検索の閾値

"" 通常オプション
set t_Co=256                          " 256色モード
set tabpagemax=100                    " タブページの最大値100
set laststatus=2                      " ステータスライン常に表示
set showtabline=2                     " タブライン常に表示
set fileencoding=utf-8                " カレントバッファ内のファイルの文字UTF-8
set updatetime=1000                   " スワップファイルの自動保存時間
set visualbell                        " ビープ音をすべて視覚表示に置き換える
set noerrorbells                      " エラーメッセージの表示時にビープ音を鳴らさない
set expandtab                         " タブ文字の代わりに半角スペース
set autoindent                        " C言語スタイルインデント
set shiftwidth=2                      " オートインデント時の空白文字数
set tabstop=2                         " <TAB>を含むファイルを開いた際,<TAB>を何文字の空白に変換するか
set softtabstop=2                     " キーボードで<TAB>を入力した際,<TAB>を何文字の空白に変換するか
set number                            " 行数表示
set incsearch                         " インクリメンタルサーチ
set hlsearch                          " サーチ結果ハイライト
set autoread                          " 外部で変更のあったファイルを自動的に読み直す
set backspace=indent,eol,start        " インサートモード時backspece有効
set nrformats=octal                   " <C-a>,<C-x>で使う基数を10進数に
set virtualedit=block                 " 矩形ビジュアル無文字部分カーソル移動
set scrolloff=5                       " 上下5行の表示を固定
set ttyfast                           " 横分割かつ,ターミナルが部分スクロールをサポートしていないとき,再描画が滑らかになる
set lazyredraw                        " スクリプト実行中に画面を描画しない
set nowrapscan                        " ファイルの末端で検索を止める
set splitbelow                        " 新しいウィンドウを下に開く
set splitright                        " 新しいウィンドウを右に開く
set iskeyword+=@-@,-                  " @と-を単語の一部とみなす
set tags=.tags,tags                   " tagsファイル読み込み
set list                              " listモード(タブや行末を文字表示する)
set listchars=tab:»-,trail:_          " listモードでタブと行末の空白を表示する
set grepprg=ag\ --nogroup\ --nocolor  " grepをagで行う
set grepformat=%f:%l:%m               " grepのフォーマット(ag用)

"" 補完ポップアップメニュー色設定
hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=12 guibg=SlateBlue
hi PmenuSbar ctermbg=0 guibg=#404040
hi PmenuThumb ctermbg=0 guibg=Red

"" cnoremap
" コマンドライン先頭へ移動
cnoremap <C-a> <HOME>
" コマンドライン末尾へ移動
cnoremap <C-e> <END>
" コマンドライン一文字戻る,補完メニューディレクトリ右移動
cnoremap <C-b> <LEFT>
" コマンドライン一文字進む,補完メニューディレクトリ左移動
cnoremap <C-f> <RIGHT>
" コマンドライン履歴を進む,補完メニューサブディレクトリ移動
cnoremap <C-k> <DOWN>
" コマンドライン履歴を戻る,補完メニューディレクトリ戻る
cnoremap <C-_> <UP>
" コマンドライン文字削除,補完メニュー文字削除
cnoremap <C-d> <DEL>
" コマンドラインでkill-wordと似た動作をする
cnoremap <C-u> <S-RIGHT><C-w>
" コマンドラインにカーソル上の文字を入力
cnoremap <C-]> <C-r><C-w>
" コマンドラインに検索した文字列を入力
cnoremap <C-w>* <C-r>/

"" noremap
" ,はleaderとして使用
noremap , <NOP>
" 逆vi-forward-word
noremap <C-s>; ,
" <C-f>と<C-b>を無効化
noremap <C-f> <NOP>
noremap <C-b> <NOP>
" <ESC>
noremap <C-j> <ESC>
" ファイル再読込
noremap <leader>r :<C-u>e!<CR>:<C-u>checktime<CR>
" カーソル行が画面の上端に来るようにスクロール
noremap <C-s>j zt
noremap <C-s><C-j> zt
"" ウィンドウ関連
" ウィンドウのmapに関わるデフォルトのmapを無効化
noremap <C-w>P <NOP>
noremap <C-w>q <NOP>
noremap <C-w><C-w> <NOP>
noremap <C-w>W <NOP>
" 次のウィンドウへ移動
noremap <C-w>n <C-w>w
noremap <C-w><C-n> <C-w>w
" 前のウィンドウへ移動
noremap <C-w>p <C-w>W
noremap <C-w><C-p> <C-w>W
" ウィンドウ分割
noremap <C-w>v <NOP>
noremap <C-w>i <C-w>v
"" タブ関連
" タブのmapに関わるデフォルトのmapを無効化
noremap ] <NOP>
noremap [ <NOP>
noremap gt <NOP>
noremap gT <NOP>
noremap <C-]> <NOP>
noremap <C-[> <NOP>
noremap <C-w>X <NOP>
noremap <C-w>] <NOP>
noremap <C-w>[ <NOP>
noremap <C-w><C-]> <NOP>
noremap <C-w><C-[> <NOP>
" 新しいタブを作成
noremap <C-w>t :<C-u>tabnew<CR>
" 次のタブへ移動
noremap <C-w>] gt
noremap <C-w><C-]> gt
" 前のバッファへ移動
noremap <C-w>[ gT
noremap <C-w><C-[> gT
" <C-w>1..9で任意の番号のタブへ移動
for s:i in range(1, 9)
  execute 'noremap <C-w>'.s:i.' <NOP>'
  execute 'noremap <C-w>'.s:i.' :<C-u>tabnext '.s:i.'<CR>'
endfor
" タブを閉じる
noremap <C-w>X :<C-u>tabclose<CR>
"" バッファ関連
" 直前のバッファに戻る
noremap <C-s>_ <C-^>
noremap <C-s><C-_> <C-^>
"" タグ(ctags)関連
" タグのmapに関わるデフォルトのmapを無効化
noremap <C-t> <NOP>
noremap g<C-]> <NOP>
noremap <C-w>} <NOP>
" カーソル位置の単語をタグとしてジャンプ
noremap <C-s>t <C-]>
" 複数候補がある時タグリスト表示
noremap <C-s>T g<C-]>
" 直前のタグに戻る
noremap <C-s><C-t> <C-t>
" 次のタグへ移動
noremap <C-s>] :<C-u>tnext<CR>zz
noremap <C-s><C-]> :<C-u>tnext<CR>zz
" 前のタグへ移動
noremap <C-s>[ :<C-u>tprevious<CR>zz
noremap <C-s><C-[> :<C-u>tprevious<CR>zz

"" nnoremap
" recording
nnoremap q <NOP>
nnoremap <leader>q q
" <C-g>無効化
nnoremap <C-g> <NOP>
" j,kで表示単位移動
nnoremap <silent> j gj
nnoremap <silent> gj j
nnoremap <silent> k gk
nnoremap <silent> gk k
nnoremap <silent> $ g$
nnoremap <silent> g$ $
nnoremap <silent> <leader>0 `<
nnoremap <silent> <leader>$ `>
" 検索後にカーソルを上に移動
nnoremap n nzz
nnoremap N Nzz
" <ESC>か<C-j>2回で再描画&検索ハイライト消し
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
nnoremap <C-j><C-j> :<C-u>nohlsearch<CR>
" q:,q/,q?無効化
nnoremap q: <NOP>
nnoremap q/ <NOP>
nnoremap q? <NOP>
" qqq:キーコマンド履歴表示
nnoremap qqq: <ESC>q:
" qqq/,qqq?検索履歴表示
nnoremap qqq/ <ESC>q/
nnoremap qqq? <ESC>q?
" 現在のファイル名表示
nnoremap <leader>v :<C-u>echo expand('%')<CR>

"" inoremap
" ノーマルモードに切り替え<ESC>
inoremap <C-[> <ESC>
inoremap <C-j> <ESC>
" CTRL-@無効化
inoremap <C-@> <NOP>
" 右へ移動
inoremap <C-f> <RIGHT>
" 左へ移動
inoremap <C-b> <LEFT>
" 次の単語の先頭に移動
inoremap <C-]> <S-RIGHT>
" 前の単語の先頭に移動
inoremap <C-s><C-]> <S-LEFT>
" 一文字delete
inoremap <C-d> <DELETE>

"" vnoremap
" j,kで表示単位移動
vnoremap <silent> j gj
vnoremap <silent> gj j
vnoremap <silent> k gk
vnoremap <silent> gk k
vnoremap <silent> $ g$
vnoremap <silent> g$ $
nnoremap <silent> <leader>0 `<
nnoremap <silent> <leader>$ `>
" ビジュアルモードのインデント後選択継続
vnoremap < <gv
vnoremap > >gv
" <ESC>でビジュアルモード終了
vnoremap <ESC> v_<ESC>

"" autocmd
" ファイルを開いたときに最後の変更点へ移動
augroup previous_cursor_line
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | exe 'normal! g`"zz' | endif
augroup END

" ウィンドウ移動で外部でのファイル変更チェック
augroup file_change_checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" quickfixのサイズ調整
augroup adjust_quickfix_window
  autocmd!
  autocmd FileType qf exe max([min([line('$'),&lines/2]),5]).'wincmd _'
augroup END

" insertモード終了時自動でpasteモードを終了する
augroup auto_paste_leave
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END

" netrwhistを削除する
augroup delete_netrwhist
  autocmd!
  autocmd VimLeave * if filereadable(expand(vim_dir_path.'/.netrwhist')) | call delete(expand(vim_dir_path.'/.netrwhist')) | endif
augroup END
