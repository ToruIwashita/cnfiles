""" オプション
set encoding=utf8               " エンコーディングUTF-8
set fileencoding=utf-8          " カレントバッファ内のファイルの文字UTF-8
set expandtab                   " タブ文字の代わりに半角スペース
set number                      " 行数表示
set noautoindent                " オートインデント無効
set wildmode=longest:full,full  " コマンドライン補完

""" インサートモードキーバインド
inoremap <C-b> <Left>   " Ctr+bで左へ移動
inoremap <C-f> <Right>  " Ctr+fで右へ移動
inoremap <C-n> <Down>   " Ctr+nで下へ移動
inoremap <C-p> <Up>     " Ctr+pで上へ移動
noremap <C-z> <Nop>     " Ctr+z無効化
