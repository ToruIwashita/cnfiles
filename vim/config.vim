"" FILE: config.vim
" Vimの基本的な設定を記述

"" leader
let mapleader = ','

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
set encoding=utf8               " エンコーディングUTF-8
set t_Co=256                    " 256色モード
set laststatus=2                " ステータスライン常に表示
set showtabline=2               " タブライン常に表示
set fileencoding=utf-8          " カレントバッファ内のファイルの文字UTF-8
set expandtab                   " タブ文字の代わりに半角スペース
set autoindent                  " C言語スタイルインデント
set shiftwidth=2                " オートインデント時の空白文字数
set tabstop=2                   " tabが対応する空白の文字数
set number                      " 行数表示
set incsearch                   " インクリメンタルサーチ
set hlsearch                    " サーチ結果ハイライト
set autoread                    " 外部で変更のあったファイルを自動的に読み直す
set backspace=indent,eol,start  " インサートモード時backspece有効
set nrformats=octal             " <C-a>,<C-x>で使う基数を10進数に
set virtualedit=block           " 矩形ビジュアル無文字部分カーソル移動
set scrolloff=2                 " 上下3行の表示を固定
set ttyfast                     " 横分割かつ,ターミナルが部分スクロールをサポートしていないとき,再描画が滑らかになる
set lazyredraw                  " スクリプト実行中に画面を描画しない
set nowrapscan                  " ファイルの末端で検索を止める
set tags=.tags,tags             " tagsファイル読み込み

"" 補完ポップアップメニュー色設定
hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=12 guibg=SlateBlue
hi PmenuSbar ctermbg=0 guibg=#404040
hi PmenuThumb ctermbg=0 guibg=Red

"" cnoremap
" コマンドラインモード先頭へ移動
cnoremap <C-a> <HOME>
" コマンドラインモード末尾へ移動
cnoremap <C-e> <END>
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
" ,はleaderとして使用
noremap , <NOP>
" サスペンド無効化
noremap <C-z> <NOP>
" ファイル保存
noremap <C-i> :<C-u>:w<CR>
" <ESC>
noremap <C-j> <ESC>
" 現在のバッファ削除
noremap <C-w>x <NOP>
noremap <C-w>x :<C-u>bdelete<CR>
" ウィンドウ関連
" ウィンドウのmapに関わるデフォルトのmapを無効化
noremap <C-w>P <NOP>
noremap <C-w>q <NOP>
noremap <C-w>w <NOP>
noremap <C-w><C-w> <NOP>
noremap <C-w>W <NOP>
noremap <C-w><C-W> <NOP>
" 次のウィンドウへ移動
noremap <C-w>n <C-w>w
noremap <C-w><C-n> <C-w>w
" 前のウィンドウへ移動
noremap <C-w>p <C-w>W
noremap <C-w><C-p> <C-w>W
" タブ関連
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
noremap <C-w><C-t> :<C-u>tabnew<CR>
" 次のタブへ移動
noremap <C-w>] gt
noremap <C-w><C-]> gt
" 前のバッファへ移動
noremap <C-w>[ gT
noremap <C-w><C-[> gT
" <C-w>1..9で任意の番号のタブへ移動
for i in range(1, 9)
  execute 'nnoremap <C-w>'.i.' <NOP>'
  execute 'nnoremap <C-w>'.i.' :<C-u>tabnext '.i.'<CR>'
endfor
" 現在のバッファを新しいタブで開く
noremap <C-w>! :<C-u>tabedit %<CR>
" タブを閉じる
noremap <C-w>X :<C-u>tabclose<CR>
" タグ(ctags)関連
" タグのmapに関わるデフォルトのmapを無効化
noremap <C-t> <NOP>
noremap g<C-]> <NOP>
noremap <C-w>} <NOP>
" カーソル位置の単語をタグとしてジャンプ
noremap <C-t>t <C-]>
" 直前のタグに戻る
noremap <C-t>T <C-t>
" 複数候補がある時タグリスト表示
noremap <C-t><C-t> g<C-]>
" カーソル位置の単語の定義をプレビューウィンドウで開く
noremap <C-t>w <C-w>}
" 次のタグへ移動
noremap <C-t>] :<C-u>tnext<CR>
noremap <C-t><C-]> :<C-u>tnext<CR>
" 前のタグへ移動
noremap <C-t>[ :<C-u>tprevious<CR>
noremap <C-t><C-[> :<C-u>tprevious<CR>
" preview,quickfixウィンドウクローズ
noremap <silent> <C-w>w :<C-u>cclose<CR>:lclose<CR>:pclose<CR>
" カーソル上の文字列を置換対象として:%sに配置する
noremap <leader>s :<C-u>%s/<C-r><C-w>/

"" nnoremap
" *,#で検索した後に移動しない
nnoremap * *N
nnoremap # #N
" 検索後にカーソルを中央に移動
nnoremap n nzz
nnoremap N Nzz
" <ESC>か<C-j>2回で検索ハイライト消し
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
nnoremap <C-j><C-j> :<C-u>nohlsearch<CR>
" qqq:キーコマンド履歴表示
nnoremap qqq: <ESC>q:
" qqq/,qqq?検索履歴表示
nnoremap qqq/ <ESC>q/
nnoremap qqq? <ESC>q?
" q:,q/,q?無効化
nnoremap q: <NOP>
nnoremap q/ <NOP>
nnoremap q? <NOP>

"" inoremap
" ノーマルモードに切り替え<ESC>
inoremap <C-[> <ESC>
inoremap <C-]> <ESC>
inoremap <C-j> <ESC>
" CTRL-@無効化
inoremap <C-@> <NOP>
" 一文字delete
inoremap <C-d> <delete>

"" vnoremap
" ビジュアルモードのインデント後選択継続
vnoremap < <gv
vnoremap > >gv
" <ESC>でビジュアルモード終了
vnoremap <ESC> v_<ESC>

"" cnoreabbrev
cnorea t :<C-u>tabnew
cnorea ts :<C-u>tselect
cnorea pt :<C-u>ptag
cnorea ev :<C-u>source ~/.vimrc

"" autocmd
" ファイルを開いたときに最後の変更点へ移動
augroup PreviousCursorLine
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" ウィンドウ移動で外部でのファイル変更チェック
augroup VimrcChecktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" quickfixのサイズ調整
augroup AdjustQuickfixWindow
  autocmd!
  autocmd FileType qf exe max([min([line('$'),&lines/2]),10]).'wincmd _'
augroup END
