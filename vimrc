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
  set nocompatible  " Be iMproved

  set runtimepath+=~/.vim/bundle/neobundle.vim/
  exe 'set rtp+='.globpath($GOPATH, 'src/github.com/nsf/gocode/vim')
endif
" neobundle.vimの初期化
call neobundle#begin(expand('~/.vim/bundle/'))

"" group 各種vimプラグイン do
" NeoBundle自身をNeoBundleで管理する(更新する)
NeoBundleFetch 'Shougo/neobundle.vim'
" 非同期処理を可能にするプラグイン('build'は自動インストール設定)
NeoBundle 'Shougo/vimproc', {
  \ 'build': {
  \   'mac': 'make -f make_mac.mak',
  \   'unix': 'make -f make_unix.mak'
  \ }
\ }
if has('lua')
  NeoBundle 'Shougo/neocomplete'  " 入力補完機能
endif
NeoBundle 'Shougo/neosnippet'               " スニペット展開
NeoBundle 'honza/vim-snippets'              " 各種snippet
NeoBundle 'tpope/vim-repeat'                " vim-surroundの機能を.反復
NeoBundle 'tpope/vim-abolish'               " 強化版置換コマンド
NeoBundle 'tpope/vim-fugitive'              " fugitive(ステータスラインのブランチ名と,Gblame用)
NeoBundle 'tpope/vim-surround'              " text-object操作
NeoBundle 'xolox/vim-misc'                  " vim-sessionが依存しているplugin(dependsで依存を表せるが敢えてしていない)
NeoBundle 'xolox/vim-session'               " セッション保存
NeoBundle 'kana/vim-textobj-user'           " 独自text-object定義
NeoBundle 'kana/vim-textobj-line'           " lineのtext-object(vim-textobj-userに依存している)
NeoBundle 'vim-ruby/vim-ruby'               " vim-ruby
NeoBundle 'ngmy/vim-rubocop'                " vim-rubocop
NeoBundle 'kchmck/vim-coffee-script'        " vim-coffee-script
NeoBundle 'tomtom/tcomment_vim'             " コメントアウト
NeoBundle 'itchyny/lightline.vim'           " ステータスライン
NeoBundle 'thinca/vim-visualstar'           " visualstar(選択範囲のテキストで検索)
NeoBundle 'thinca/vim-prettyprint'          " vimのデバッグ用prettyprint
NeoBundle 'thinca/vim-quickrun'             " バッファ上のソースコードを実行してvimへ出力
NeoBundle 'thinca/vim-tabrecent'            " 直前のタブに戻る
NeoBundle 'osyo-manga/shabadou.vim'         " 汎用的なquickrun-hook
NeoBundle 'osyo-manga/vim-over'             " 置換プレビュー
NeoBundle 'tmux-plugins/vim-tmux'           " vim-tmux
NeoBundle 't9md/vim-choosewin'              " ウィンドウ対話的選択
NeoBundle 'gregsexton/gitv'                 " gitv(コミットログ閲覧用)
NeoBundle 'scrooloose/nerdtree'             " ファイラー
NeoBundle 'scrooloose/syntastic'            " シンタックスチェック
NeoBundle 'ctrlpvim/ctrlp.vim'              " 多機能finder
NeoBundle 'tacahiroy/ctrlp-funky'           " ctrlpで関数を絞り込む
NeoBundle 'jasoncodes/ctrlp-modified.vim'   " ctrlpでgitで変更があったファイルを絞り込む
NeoBundle 'dyng/ctrlsf.vim'                 " 文字列検索
NeoBundle 'gcmt/wildfire.vim'               " text-object選択
NeoBundle 'plasticboy/vim-markdown'         " vim-markdown
NeoBundle 'fugalh/desert.vim'               " カラースキーマ
NeoBundle 'junegunn/vim-easy-align'         " テキスト整形
NeoBundle 'soramugi/auto-ctags.vim'         " ctags生成
NeoBundle 'vim-jp/vim-go-extra'             " extra vim plugin for go
NeoBundle 'tmhedberg/matchit'               " 対応する括弧などにジャンプする
NeoBundle 'jiangmiao/auto-pairs'            " 自動で閉じ記号を付与
NeoBundle 'kshenoy/vim-signature'           " マーカー表示
NeoBundle 'adie/BlockDiff'                  " BlockDiff(選択範囲の比較)
NeoBundle 'LeafCage/yankround.vim'          " ヤンク履歴管理
NeoBundle 'vim-scripts/AnsiEsc.vim'         " ANSIカラー表示
NeoBundle 'vim-scripts/QuickBuf'            " バッファ操作
NeoBundle 'ToruIwashita/tabmove-assist.vim' " タブ移動補助
NeoBundle 'ToruIwashita/tag-tnjump.vim'     " タグジャンプ補助

call neobundle#end()

" ファイルタイプの検出,ファイルタイプ用プラグインプラグイン,インデントを有効化(NeoBundleによる処理が終了した後に実施)
filetype plugin indent on

NeoBundleCheck

"" 各種設定読込
if filereadable(expand('~/.vim/config.vim')) | source ~/.vim/config.vim | en
if filereadable(expand('~/.vim/config.plugin.vim')) | source ~/.vim/config.plugin.vim | en
