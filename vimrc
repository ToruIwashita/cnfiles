"" 初期設定
" vi互換モードoff(純正のvim設定適用)
set nocompatible
" 起動時にvim-plugの存在チェック
if has('vim_starting')
  set runtimepath+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug'
    call mkdir('~/.vim/plugged/vim-plug', 'p')
    call system('git clone git@github.com:junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif

let g:plug_url_format = 'git@github.com:%s.git'

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}
Plug 'Shougo/vimproc',    {'do': 'make'}
Plug 'Shougo/neocomplete'              " 入力補完機能(luajit依存)
Plug 'Shougo/neosnippet'               " スニペット展開
Plug 'honza/vim-snippets'              " 各種snippet
Plug 'tpope/vim-repeat'                " vim-surroundの機能を.反復
Plug 'tpope/vim-abolish'               " 強化版置換コマンド
Plug 'tpope/vim-fugitive'              " fugitive(ステータスラインのブランチ名と,Gblame用)
Plug 'tpope/vim-surround'              " text-object操作
Plug 'xolox/vim-misc'                  " vim-sessionが依存しているplugin(dependsで依存を表せるが敢えてしていない)
Plug 'xolox/vim-session'               " セッション保存
Plug 'kana/vim-submode'                " 連続入力などをサポートするサブモードを定義する
Plug 'kana/vim-textobj-user'           " 独自text-object定義
Plug 'kana/vim-textobj-line'           " lineのtext-object(vim-textobj-user依存)
Plug 'kana/vim-textobj-indent'         " カーゾル行と同じインデントのtext-object(vim-textobj-user依存)
Plug 'kana/vim-niceblock'              " ビジュアル選択時にI,Aで行頭,行末に文字挿入
Plug 'vim-ruby/vim-ruby'               " vim-ruby
Plug 'ngmy/vim-rubocop'                " vim-rubocop
Plug 'kchmck/vim-coffee-script'        " vim-coffee-script
Plug 'tomtom/tcomment_vim'             " コメントアウト
Plug 'itchyny/lightline.vim'           " ステータスライン
Plug 'thinca/vim-visualstar'           " visualstar(選択範囲のテキストで検索)
Plug 'thinca/vim-prettyprint'          " vimのデバッグ用prettyprint
Plug 'thinca/vim-quickrun'             " バッファ上のソースコードを実行してvimへ出力
Plug 'thinca/vim-tabrecent'            " 直前のタブに戻る
Plug 'osyo-manga/shabadou.vim'         " 汎用的なquickrun-hook
Plug 'osyo-manga/vim-over'             " 置換プレビュー
Plug 'tmux-plugins/vim-tmux'           " tmux用プラグイン
Plug 't9md/vim-choosewin'              " ウィンドウ対話的選択
Plug 'gregsexton/gitv'                 " gitv(コミットログ閲覧用)
Plug 'scrooloose/syntastic'            " シンタックスチェック
Plug 'ctrlpvim/ctrlp.vim'              " 多機能finder
Plug 'tacahiroy/ctrlp-funky'           " ctrlpで関数を絞り込む
Plug 'jasoncodes/ctrlp-modified.vim'   " ctrlpでgitで変更があったファイルを絞り込む
Plug 'dyng/ctrlsf.vim'                 " 文字列検索
Plug 'gcmt/wildfire.vim'               " text-object選択
Plug 'plasticboy/vim-markdown'         " vim-markdown
Plug 'fugalh/desert.vim'               " カラースキーマ
Plug 'junegunn/vim-easy-align'         " テキスト整形
Plug 'soramugi/auto-ctags.vim'         " ctags生成
Plug 'majutsushi/tagbar'               " コード概要ビューア
Plug 'vim-jp/vim-go-extra'             " extra vim plugin for go
Plug 'tmhedberg/matchit'               " 対応する括弧などにジャンプする
Plug 'jiangmiao/auto-pairs'            " 自動で閉じ記号を付与
Plug 'kshenoy/vim-signature'           " マーカー表示
Plug 'adie/BlockDiff'                  " BlockDiff(選択範囲の比較)
Plug 'LeafCage/yankround.vim'          " ヤンク履歴管理
Plug 'Konfekt/FastFold'                " 自動折畳
Plug 'chrisbra/vim-zsh'                " zsh用プラグイン
Plug 'vim-scripts/AnsiEsc.vim'         " ANSIカラー表示
Plug 'vim-scripts/QuickBuf'            " バッファ操作
Plug 'ToruIwashita/tabmove-assist.vim' " タブ移動補助
Plug 'ToruIwashita/tag-tnjump.vim'     " タグジャンプ補助
Plug 'ToruIwashita/window-closer.vim'  " ウィンドウを閉じる動作の制御
Plug 'ToruIwashita/git-switcher.vim'   " git管理プロジェクトのセッション切り替え

call plug#end()

"" 各種設定読込
if filereadable(expand('~/.vim/config.vim')) | source ~/.vim/config.vim | en
if filereadable(expand('~/.vim/config.plugin.vim')) | source ~/.vim/config.plugin.vim | en
