"" オプション
" エンコーディングUTF-8
set encoding=utf8
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

"" コマンドモードキーバインド
" 次のウィンドウへ移動
noremap <C-w>n <C-w>w
noremap <C-w><C-n> <C-w>w
" 前のウィンドウへ移動
noremap <C-w>p <C-w>W
noremap <C-w><C-p> <C-w>W

" unbind-keys
noremap <C-z> <nop>
