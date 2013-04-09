"" コマンドモードキーバインド
" 次のウィンドウへ移動
noremap <C-w>n <C-w>w
noremap <C-w><C-n> <C-w>w
" 前のウィンドウへ移動
noremap <C-w>p <C-w>W
noremap <C-w><C-p> <C-w>W
" ウィンドウ上下分割
noremap <C-w><C-s> <nop>
noremap <C-w><C-s> <C-w><C-s>
" ウィンドウ左右分割
noremap <C-w><C-v> <nop>
noremap <C-w><C-v> <C-w><C-v>
" サスペンド無効化
noremap <C-z> <nop>
" デフォルトウィンドウ移動無効化
noremap <C-w>w <nop>
noremap <C-w><C-w> <nop>
noremap <C-w>W <nop>
noremap <C-w><C-W> <nop>

"" インサートモードキーバインド
" 一文字delete
inoremap <C-d> <delete>
" Ctr+bで左へ移動
inoremap <C-b> <left>
" Ctr+fで右へ移動
inoremap <C-f> <right>
" Ctr+nで下へ移動
inoremap <C-n> <down>
" Ctr+pで上へ移動
inoremap <C-p> <up>

"" オプション
" エンコーディングUTF-8
set encoding=utf8
" 256色モード
set t_Co=256
" カレントバッファ内のファイルの文字UTF-8
set fileencoding=utf-8
" タブ文字の代わりに半角スペース
set expandtab
" 行数表示
set number
" オートインデント無効
set noautoindent
" コマンドライン補完
set wildmode=longest:full,full
