"" 補完設定
set wildmenu
set wildmode=full

" `wildchar`:ワイルドカード展開に使用する文字(補完開始)
" `wildcharm`:マクロでも使えるワイルドカード展開に使用する文字
" 以下の設定によりコマンドラインモード(cnoremap)で元のマッピングが機能するようになる
let &wildcharm = &wildchar

"" cnoremap
" 補完メニューサブディレクトリ移動
cnoremap <C-k> <DOWN>

"" noremap
" 次のウィンドウへ移動
noremap <C-w>n <C-w>w
noremap <C-w><C-n> <C-w>w
" 前のウィンドウへ移動
noremap <C-w>p <C-w>W
noremap <C-w><C-p> <C-w>W
" ウィンドウ上下分割
noremap <C-w><C-s> <Nop>
noremap <C-w><C-s> <C-w><C-s>
" ウィンドウ左右分割
noremap <C-w><C-v> <Nop>
noremap <C-w><C-v> <C-w><C-v>
" サスペンド無効化
noremap <C-z> <Nop>
" デフォルトウィンドウ移動無効化
noremap <C-w>w <Nop>
noremap <C-w><C-w> <Nop>
noremap <C-w>W <Nop>
noremap <C-w><C-W> <Nop>
" [,],<C-[>,<C-]>,<C-w><C-[>,<C-w><C-]>無効化
noremap ] <Nop>
noremap [ <Nop>
noremap <C-]> <Nop>
noremap <C-[> <Nop>
noremap <C-w><C-]> <Nop>
noremap <C-w><C-[> <Nop>
" 次のバッファへ移動
noremap <C-w>] :bnext<CR>
noremap <C-w><C-]> :bnext<CR>
" 前のバッファへ移動
noremap <C-w>[ :bprevious<CR>
noremap <C-w><C-[> :bprevious<CR>
" 現在のバッファ削除
noremap <C-w>d :bdelete<CR>
noremap <C-w><C-d> :bdelete<CR>
" Exコマンド起動キー
noremap ; :
noremap : ;

"" nnoremap
" *,#で検索した後に移動しない
nnoremap * *N
nnoremap # #N
" <ESC>2回で検索ハイライト消し
nnoremap <ESC><ESC> :nohlsearch<CR>
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

"" オプション
" シンタックスハイライト
syntax on
" シンタックスハイライトの開始/終了タグ検索の閾値
syntax sync minlines=500 maxlines=1000
" エンコーディングUTF-8
set encoding=utf8
" 256色モード
set t_Co=256
" ステータスライン2行
set laststatus=2
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
" 横分割かつ,ターミナルが部分スクロールをサポートしていないとき,再描画が滑らかになる
set ttyfast
" スクリプト実行中に画面を描画しない
set lazyredraw

"" 補完ポップアップメニュー色設定
hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=12 guibg=SlateBlue
hi PmenuSbar ctermbg=0 guibg=#404040
hi PmenuThumb ctermbg=0 guibg=Red

"" autocommand
" markdown設定
augroup AuAddMdSpace
  autocmd!
  autocmd BufWrite *.md call g:add_md_space()
augroup END

" ruby,Buffer保存後にvim-ruby経由のmakeを-W[level=1](medium)で走らせ,再描画
augroup AuRbSyntaxCheck
  autocmd!
  autocmd BufWritePost *.rb silent make -c -W1 % | redraw!
augroup END

" quickfix,makeしたらquickfixリストを表示:
augroup AuQuickFixOpen
  autocmd!
  autocmd QuickfixCmdPost make cw
augroup END
