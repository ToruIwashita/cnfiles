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
\    'mac'  : 'make -f make_mac.mak',
\    'unix' : 'make -f make_unix.mak',
\  },
\}
" 入力補完機能
NeoBundle 'Shougo/neocomplcache'
" スニペット展開
NeoBundle 'Shougo/neosnippet'
" rubyのブロックを%で移動
NeoBundle 'ruby-matchit'
" タブで補完
NeoBundle 'SuperTab'
" ステータスライン
NeoBundle 'itchyny/lightline.vim'
" Git
NeoBundle 'fugitive.vim'
"" end

" ファイルタイププラグインおよびインデントを有効化(NeoBundleによる処理が終了した後に実施)
filetype plugin indent on

""" 各種設定読込
"" 基本設定
source ~/.vim/vconf
source ~/.vim/plugin_conf

"" その他設定読み込み
let directories = ["vfunc/","vfunc_local/","abbreviate/","macro/"]
for $dir in directories
  let $dir_path = "~/.vim/".$dir
  for $file in split(system("ls ".$dir_path),"\n")
    let $file_path = $dir_path.$file
    source $file_path
  endfor
endfor
