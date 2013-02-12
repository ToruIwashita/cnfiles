""" オプション
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

""" インサートモードキーバインド
" Ctr+bで左へ移動
inoremap <C-b> <Left>
" Ctr+fで右へ移動
inoremap <C-f> <Right>
" Ctr+nで下へ移動
inoremap <C-n> <Down>
" Ctr+pで上へ移動
inoremap <C-p> <Up>
" Ctr+z無効化
noremap <C-z> <Nop>
