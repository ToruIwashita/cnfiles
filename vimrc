""" NeoBundle設定
"" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install bundles
" :NeoBundleUpdate(!)     - update bundles
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
if has('lua')
  NeoBundle 'Shougo/neocomplete'
endif
" スニペット展開
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" text-object操作
NeoBundle 'tpope/vim-surround'
" vim-surroundの機能を.反復
NeoBundle 'tpope/vim-repeat'
" 強化版置換コマンド
NeoBundle 'tpope/vim-abolish'
" fugitive(ステータスラインのブランチ名と,Gblame用)
NeoBundle 'tpope/vim-fugitive'
" vim-ruby
NeoBundle 'vim-ruby/vim-ruby'
" ag(silver_searcher)用プラグイン
NeoBundle 'rking/ag.vim'
" コメントアウト
NeoBundle 'tomtom/tcomment_vim'
" ステータスライン
NeoBundle 'itchyny/lightline.vim'
" BlockDiff(選択範囲の比較)
NeoBundle 'adie/BlockDiff'
" visualstar(選択範囲のテキストで検索)
NeoBundle 'thinca/vim-visualstar'
" ウィンドウ対話的選択
NeoBundle 't9md/vim-choosewin'
" gitv(コミットログ閲覧用)
NeoBundle 'gregsexton/gitv'
" ファイラー
NeoBundle 'scrooloose/nerdtree'
" 多機能finder
NeoBundle 'kien/ctrlp.vim'
" text-object選択
NeoBundle 'gcmt/wildfire.vim'
" vim-markdown
NeoBundle 'hallison/vim-markdown'
" カラースキーマ
NeoBundle 'fugalh/desert.vim'
" rubyのブロックを%で移動
NeoBundle 'vim-scripts/ruby-matchit'
" ヤンク履歴管理
NeoBundle 'vim-scripts/YankRing.vim'
" テキスト整形
NeoBundle 'vim-scripts/Align'
" バッファ操作
NeoBundle 'vim-scripts/QuickBuf'
" QuickFixエラーにマーカー
NeoBundle 'vim-scripts/errormarker.vim'
"" end

" ファイルタイプの検出,ファイルタイプ用プラグインプラグイン,インデントを有効化(NeoBundleによる処理が終了した後に実施)
filetype plugin indent on

""" 各種設定読込
"" 基本設定
source ~/.vim/config.vim
source ~/.vim/config.bundle.vim
