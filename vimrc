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
\    'mac' : 'make -f make_mac.mak',
\    'unix' : 'make -f make_unix.mak',
\  },
\}
" rails用vimプラグイン
NeoBundle 'rails.vim'
" 入力補完機能プラグイン
NeoBundle 'Shougo/neocomplcache'
" neocomplcacheでrsenseを使用するためのプラグイン
NeoBundle 'Shougo/neocomplcache-rsense'
" スニペット展開
NeoBundle 'Shougo/neosnippet'
" rsenseをvimで利用するためのプラグイン
NeoBundle 'taichouchou2/vim-rsense'
" タブで補完
NeoBundle 'SuperTab'
"" end

" ファイルタイププラグインおよびインデントを有効化(NeoBundleによる処理が終了した後に実施)
filetype plugin indent on

""" 各種設定読込
"" 基本設定
source ~/.vim/vconf
source ~/.vim/plugin_conf

"" その他設定読み込み
let directories = ["abbreviate/","macro/"]
for $dir in directories
  let $dir_path = "~/.vim/".$dir
  for $file in split(system("ls ".$dir_path),"\n")
    let $file_path = $dir_path.$file
    source $file_path
  endfor
endfor
