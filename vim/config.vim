"" FILE: config.vim
" Vimの基本的な設定を記述

"" 補完設定
set wildmenu
set wildmode=full

" `wildchar`:ワイルドカード展開に使用する文字(補完開始)
" `wildcharm`:マクロでも使えるワイルドカード展開に使用する文字
" 以下の設定によりコマンドラインモード(cnoremap)で元のマッピングが機能するようになる
let &wildcharm = &wildchar

"" cnoremap
" コマンドラインモード先頭へ移動
cnoremap <C-a> <HOME>
" コマンドラインモード末尾へ移動
cnoremap <C-a> <HOME>
" コマンドラインモード一文字戻る,補完メニューディレクトリ右移動
cnoremap <C-b> <LEFT>
" コマンドラインモード一文字進む,補完メニューディレクトリ左移動
cnoremap <C-f> <RIGHT>
" コマンドラインモード履歴を進む,補完メニューサブディレクトリ移動
cnoremap <C-k> <DOWN>
" コマンドラインモード履歴を戻る,補完メニューディレクトリ戻る
cnoremap <C-_> <UP>
" 補完メニュー文字削除
cnoremap <C-d> <DEL>

"" noremap
" サスペンド無効化
noremap <C-z> <Nop>
" 現在のバッファ削除
noremap <C-w>x <Nop>
noremap <C-w>x :<C-u>bdelete<CR>
" ウィンドウ関連
" ウィンドウのmapに関わるデフォルトのmapを無効化
noremap <C-w>w <Nop>
noremap <C-w><C-w> <Nop>
noremap <C-w>W <Nop>
noremap <C-w><C-W> <Nop>
" 次のウィンドウへ移動
noremap <C-w>n <C-w>w
noremap <C-w><C-n> <C-w>w
" 前のウィンドウへ移動
noremap <C-w>p <C-w>W
noremap <C-w><C-p> <C-w>W
" タブ関連
" タブのmapに関わるデフォルトのmapを無効化
noremap ] <Nop>
noremap [ <Nop>
noremap <C-]> <Nop>
noremap <C-[> <Nop>
noremap <C-w>X <Nop>
noremap <C-w>] <Nop>
noremap <C-w>[ <Nop>
noremap <C-w><C-]> <Nop>
noremap <C-w><C-[> <Nop>
noremap <C-w>c <Nop>
noremap <C-w><C-c> <Nop>
" 新しいタブを作成
noremap <C-w>c :<C-u>tabnew<CR>
noremap <C-w><C-c> :<C-u>tabnew<CR>
" 次のタブへ移動
noremap <C-w>] :<C-u>tabnext<CR>
noremap <C-w><C-]> :<C-u>tabnext<CR>
" 前のバッファへ移動
noremap <C-w>[ :<C-u>tabprevious<CR>
noremap <C-w><C-[> :<C-u>tabprevious<CR>
for i in range(1, 9)
  execute 'nnoremap <C-w>'.i.' <Nop>'
  execute 'nnoremap <C-w>'.i.' :<C-u>tabnext '.i.'<CR>'
endfor
" タブを閉じる
noremap <C-w>X :<C-u>tabclose<CR>

"" nnoremap
" *,#で検索した後に移動しない
nnoremap * *N
nnoremap # #N
" 検索後にカーソルを中央に移動
nnoremap n nzz
nnoremap N Nzz
" <ESC>2回で検索ハイライト消し
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
" qqq:キーコマンド履歴表示
nnoremap qqq: <Esc>q:
" qqq/,qqq?検索履歴表示
nnoremap qqq/ <Esc>q/
nnoremap qqq? <Esc>q?
" q:,q/,q?無効化
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

"" inoremap
" ノーマルモードに切り替え
inoremap <C-[> <ESC>
inoremap <C-]> <ESC>
" CTRL-@無効化
inoremap <C-@> <Nop>
" 一文字delete
inoremap <C-d> <delete>

"" vnoremap
" ビジュアルモードのインデント後選択継続
vnoremap < <gv
vnoremap > >gv
" <ESC>でビジュアルモード終了
vnoremap <ESC> v_<ESC>

"" cnoreabbrev
cnorea t tabnew

"" オプション
" シンタックスハイライト
syntax on
" シンタックスハイライトの開始/終了タグ検索の閾値
syntax sync minlines=500 maxlines=1000
" エンコーディングUTF-8
set encoding=utf8
" 256色モード
set t_Co=256
" ステータスライン常に表示
set laststatus=2
" タブライン常に表示
set showtabline=2
" カレントバッファ内のファイルの文字UTF-8
set fileencoding=utf-8
" タブ文字の代わりに半角スペース
set expandtab
" C言語スタイルインデント
set autoindent
" オートインデント時の空白文字数
set shiftwidth=2
" tabが対応する空白の文字数
set tabstop=2
" 行数表示
set number
" インクリメンタルサーチ
set incsearch
" サーチ結果ハイライト
set hlsearch
" インサートモード時backspece有効
set backspace=indent,eol,start
" <C-a>,<C-x>で使う基数を10進数に
set nrformats=octal
" 矩形ビジュアル無文字部分カーソル移動
set virtualedit=block
" 上下3行の表示を固定
set scrolloff=2
" 横分割かつ,ターミナルが部分スクロールをサポートしていないとき,再描画が滑らかになる
set ttyfast
" スクリプト実行中に画面を描画しない
set lazyredraw

"" 補完ポップアップメニュー色設定
hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=12 guibg=SlateBlue
hi PmenuSbar ctermbg=0 guibg=#404040
hi PmenuThumb ctermbg=0 guibg=Red
