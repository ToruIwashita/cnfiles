"" FILE: vimrc
set encoding=utf-8
scriptencoding utf-8

"" 初期設定
let g:vim_dir_path = $VIM_DIR_PATH
let g:home_dir_path = $HOME
let g:cache_dir_path = $CACHE_DIR_PATH
let g:lint_dir_path = $LINT_DIR_PATH
let g:local_dir_path = $LOCAL_DIR_PATH
let g:markdown_texts_dir_path = $MARKDOWN_TEXTS_DIR_PATH
let g:markdown_texts_modeling_session_file_path = $MARKDOWN_TEXTS_MODELING_SESSION_FILE_PATH
let g:memolist_dir_path = $MEMOLIST_DIR_PATH
let g:memolist_tmp_file_path = $MEMOLIST_TMP_FILE_PATH

" 起動時にvim-plugの存在チェック
if has('vim_starting')
  exec 'set runtimepath+='.expand(vim_dir_path.'/plugged/vim-plug')
  if !isdirectory(expand(vim_dir_path.'/plugged/vim-plug'))
    echo 'install vim-plug'
    call mkdir(expand(vim_dir_path.'/plugged/vim-plug', 'p'))
    call system('git clone git@github.com:junegunn/vim-plug.git '.expand(vim_dir_path.'/plugged/vim-plug/autoload'))
  end
endif

let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin(expand(vim_dir_path.'/plugged'))

Plug 'junegunn/vim-plug', {'dir': expand(vim_dir_path.'/plugged/vim-plug/autoload')}
Plug 'Shougo/vimproc',    {'do': 'make'}
Plug 'Shougo/neocomplete'                              " 入力補完機能(luajit依存)
Plug 'Shougo/neosnippet'                               " スニペット展開
Plug 'honza/vim-snippets'                              " 各種snippet
Plug 'tpope/vim-repeat'                                " vim-surroundの機能を.反復
Plug 'tpope/vim-abolish'                               " 強化版置換コマンド
Plug 'tpope/vim-surround'                              " text-object操作
Plug 'tpope/vim-fugitive'                              " fugitive(ステータスラインのブランチ名と,Gblame用)
Plug 'tpope/vim-rhubarb'                               " fugitiveのGbrowseでGithubを開く
Plug 'gregsexton/gitv'                                 " gitv(コミットログ閲覧用,vim-fugitive依存)
Plug 'airblade/vim-gitgutter'                          " gitの差分を左端に表示
Plug 'tyru/open-browser.vim'                           " URIをブラウザで開く
Plug 'tyru/open-browser-github.vim'                    " githubをブラウザで開く
Plug 'kannokanno/previm'                               " markdownなどのプレビュー用(open-browser依存)
Plug 'rhysd/committia.vim'                             " コミットログ入力サポート
Plug 'kana/vim-submode'                                " 連続入力などをサポートするサブモードを定義する
Plug 'kana/vim-textobj-user'                           " 独自text-object定義
Plug 'kana/vim-textobj-line'                           " lineのtext-object(vim-textobj-user依存)
Plug 'kana/vim-textobj-indent'                         " カーゾル行と同じインデントのtext-object(vim-textobj-user依存)
Plug 'kana/vim-niceblock'                              " ビジュアル選択時にI,Aで行頭,行末に文字挿入
Plug 'vim-ruby/vim-ruby'                               " vim-ruby
Plug 'ngmy/vim-rubocop'                                " vim-rubocop
Plug 'kchmck/vim-coffee-script'                        " vim-coffee-script
Plug 'ynkdir/vim-vimlparser'                           " vimlのパーサー(構文解析)
Plug 'syngan/vim-vimlint'                              " syntasticのデフォルトvimlシンタックスチェッカー
Plug 'scrooloose/nerdtree'                             " ディレクトリツリーエクスプローラー
Plug 'scrooloose/syntastic'                            " シンタックスチェック
Plug 'tomtom/tcomment_vim'                             " コメントアウト
Plug 'itchyny/lightline.vim'                           " ステータスライン
Plug 'thinca/vim-visualstar'                           " visualstar(選択範囲のテキストで検索)
Plug 'thinca/vim-prettyprint'                          " vimのデバッグ用prettyprint
Plug 'thinca/vim-quickrun'                             " バッファ上のソースコードを実行してvimへ出力
Plug 'thinca/vim-tabrecent'                            " 直前のタブに戻る
Plug 'osyo-manga/shabadou.vim'                         " 汎用的なquickrun-hook
Plug 'osyo-manga/vim-over'                             " 置換プレビュー
Plug 'fuenor/qfixgrep'                                 " プレビュー&絞り込み検索付きgrep
Plug 'glidenote/memolist.vim'                          " メモ管理
Plug 'kaneshin/ctrlp-memolist'                         " memolistをctrlpで絞り込む
Plug 'tmux-plugins/vim-tmux'                           " vim-tmux
Plug 't9md/vim-choosewin'                              " ウィンドウ対話的選択
Plug 'ctrlpvim/ctrlp.vim'                              " 多機能finder
Plug 'tacahiroy/ctrlp-funky'                           " ctrlpで関数を絞り込む
Plug 'jasoncodes/ctrlp-modified.vim'                   " ctrlpでgitで変更があったファイルを絞り込む
Plug 'dyng/ctrlsf.vim'                                 " 文字列検索
Plug 'gcmt/wildfire.vim'                               " text-object選択
Plug 'godlygeek/tabular'                               " テキストフィルタリング
Plug 'plasticboy/vim-markdown'                         " vim-markdown(vim-tabular依存)
Plug 'fugalh/desert.vim'                               " カラースキーマ
Plug 'junegunn/vim-easy-align'                         " テキスト整形
Plug 'soramugi/auto-ctags.vim'                         " ctags生成
Plug 'majutsushi/tagbar'                               " コード概要ビューア
Plug 'vim-jp/vim-go-extra'                             " extra vim plugin for go
Plug 'tmhedberg/matchit'                               " 対応する括弧などにジャンプする
Plug 'jiangmiao/auto-pairs'                            " 自動で閉じ記号を付与
Plug 'kshenoy/vim-signature'                           " マーカー表示
Plug 'adie/BlockDiff'                                  " BlockDiff(選択範囲の比較)
Plug 'LeafCage/yankround.vim'                          " ヤンク履歴管理
Plug 'Konfekt/FastFold'                                " 自動折畳
Plug 'haya14busa/vim-debugger'                         " vim script debugger
Plug 'hashivim/vim-terraform'                          " vim-terraform
Plug 'chrisbra/vim-zsh'                                " vim-zsh
Plug 'vim-scripts/AnsiEsc.vim'                         " ANSIカラー表示
Plug 'yami-beta/vim-responsive-tabline'                " タブの横幅を調整
Plug 'wannesm/wmgraphviz.vim'                          " graphviz
Plug 'ToruIwashita/tabmove-assist.vim'                 " タブ移動補助
Plug 'ToruIwashita/nimble-tag-jump.vim'                " タグジャンプ補助
Plug 'ToruIwashita/window-closer.vim'                  " ウィンドウを閉じる動作の制御
Plug 'ToruIwashita/simple-git-push.vim'                " git pushのインターフェースを提供
Plug 'ToruIwashita/simple-git-pull-rebase.vim'         " git pull --rebaseのインターフェースを提供
Plug 'ToruIwashita/simple-git-reset-latest-commit.vim' " git reset HEAD^のインターフェースを提供
Plug 'ToruIwashita/add-git-managed-file-to-buffer.vim' " untracked, modified, changedなファイルをバッファにのせる
Plug 'ToruIwashita/git-switcher.vim'                   " git管理プロジェクトのセッション切り替え

call plug#end()

"" 各種設定読込
if filereadable(expand(vim_dir_path.'/config.vim')) | exec 'source' expand(vim_dir_path.'/config.vim') | en
if filereadable(expand(vim_dir_path.'/config.plugin.vim')) | exec 'source' expand(vim_dir_path.'/config.plugin.vim') | en
if filereadable(expand(vim_dir_path.'/config.local.vim')) | exec 'source' expand(vim_dir_path.'/config.local.vim') | en
