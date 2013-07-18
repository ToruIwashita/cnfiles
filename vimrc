""" 各種設定読込
"" 基本設定
source ~/.vim/vconf
source ~/.vim/vconf_local

"" その他設定読み込み
let directories = ["abbreviate/","abbreviate_local/","macro/","macro_local/"]
for $dir in directories
  let $dir_path = "~/.vim/".$dir
  for $file in split(system("ls ".$dir_path),"\n")
    let $file_path = $dir_path.$file
    source $file_path
  endfor
endfor

""" NeoBundle設定
"" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" 初期設定
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"" group 各種vimプラグイン do

" NeoBundle自身をNeoBundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
" 非同期処理を可能にするプラグイン(インストール推奨)
NeoBundle 'Shougo/vimproc', {
\  'build' : {
\    'windows' : 'make -f make_mingw32.mak',
\    'cygwin' : 'make -f make_cygwin.mak',
\    'mac' : 'make -f make_mac.mak',
\    'unix' : 'make -f make_unix.mak',
\  },
\}
" rails用vimプラグイン
NeoBundle 'rails.vim'
" 入力補完機能プラグイン
NeoBundle 'neocomplcache'
" スニペット展開
NeoBundle 'neosnippet'
" rsenseをvimで利用するためのプラグイン
NeoBundle 'taichouchou2/vim-rsense'

"" end

" ファイルタイププラグインおよびインデントを有効化(NeoBundleによる処理が終了した後に実施)
filetype plugin indent on
