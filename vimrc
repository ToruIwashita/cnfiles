""" NeoBundle設定
"" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

"" 初期設定
" vi互換モードoff(純正のvim設定適用)
set nocompatible
filetype off
" 起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" neobundle.vimの初期化
call neobundle#rc(expand('~/.vim/bundle/'))

"" group 各種vimプラグイン do
" NeoBundle自身をNeoBundleで管理する(更新する)
NeoBundleFetch 'Shougo/neobundle.vim'
" 非同期処理を可能にするプラグイン('build'は自動インストール設定)
NeoBundle 'Shougo/vimproc', {
\  'build' : {
\    'mac'  : 'make -f make_mac.mak',
\    'unix' : 'make -f make_unix.mak',
\  },
\}
" 入力補完機能
NeoBundle 'Shougo/neocomplete'
" スニペット展開
NeoBundle 'Shougo/neosnippet'
" text-object操作
NeoBundle 'tpope/vim-surround'
" vim-surroundの機能を.反復
NeoBundle 'tpope/vim-repeat'
" コメントアウト
NeoBundle 'tomtom/tcomment_vim'
" rubyのブロックを%で移動
NeoBundle 'ruby-matchit'
" タブで補完
NeoBundle 'SuperTab'
" ステータスライン
NeoBundle 'itchyny/lightline.vim'
" BlockDiff(選択範囲の比較)
NeoBundle 'adie/BlockDiff'
" visualstar(選択範囲のテキストで検索)
NeoBundle 'thinca/vim-visualstar'
" テキスト整形
NeoBundle 'vim-scripts/Align'
" バッファ操作
NeoBundle 'QuickBuf'
" Git
NeoBundle 'tpope/vim-fugitive'
" ファイラー
NeoBundle 'scrooloose/nerdtree'
" ヤンク履歴管理
NeoBundle 'YankRing.vim'
" vim-ruby
NeoBundle 'vim-ruby/vim-ruby'
" QuickFixエラーにマーカー
NeoBundle 'errormarker.vim'
"" end

" ファイルタイププラグインおよびインデントを有効化(NeoBundleによる処理が終了した後に実施)
filetype plugin indent on

""" 各種設定読込
"" 基本設定
source ~/.vim/config
source ~/.vim/config.plugin

"" その他設定読み込み
let directories = ["plugin/","etc/"]
for $dir in directories
  let $dir_path = "~/.vim/".$dir
  for $file in split(system("ls ".$dir_path),"\n")
    let $file_path = $dir_path.$file
    source $file_path
  endfor
endfor

