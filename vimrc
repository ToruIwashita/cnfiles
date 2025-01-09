"" FILE: vimrc
set encoding=utf-8
scriptencoding utf-8

"" 初期設定
let g:vim_dir_path = $VIM_DIR_PATH
let g:home_dir_path = $HOME
let g:local_dir_path = $LOCAL_DIR_PATH
let g:config_dir_path = $CONFIG_DIR_PATH
let g:lint_dir_path = $LINT_DIR_PATH
let g:cache_dir_path = $CACHE_DIR_PATH
let g:markdown_texts_dir_path = $MARKDOWN_TEXTS_DIR_PATH
let g:markdown_texts_modeling_session_file_path = $MARKDOWN_TEXTS_MODELING_SESSION_FILE_PATH
let g:memolist_dir_path = $MEMOLIST_DIR_PATH
let g:memolist_task_markdown_file_path = $MEMOLIST_TASK_MARKDOWN_FILE_PATH
let g:memolist_tmp_markdown_file_path = $MEMOLIST_TMP_MARKDOWN_FILE_PATH
let g:memolist_tmp_sql_file_path = $MEMOLIST_TMP_SQL_FILE_PATH
let g:memolist_tmp_text_file_path = $MEMOLIST_TMP_TEXT_FILE_PATH
let g:memolist_tmp_uml_file_path = $MEMOLIST_TMP_UML_FILE_PATH
let g:memolist_tmp_json_file_path = $MEMOLIST_TMP_JSON_FILE_PATH

"" 組込みプラグイン
source $VIMRUNTIME/macros/matchit.vim  " 対応する括弧などにジャンプする

"" 起動時にvim-plugの存在チェック
if has('vim_starting')
  exec 'set runtimepath+='.expand(g:vim_dir_path.'/plugged/vim-plug')
  if !isdirectory(expand(g:vim_dir_path.'/plugged/vim-plug'))
    echo 'install vim-plug'
    call mkdir(expand(g:vim_dir_path.'/plugged/vim-plug'), 'p')
    call system('git clone git@github.com:junegunn/vim-plug.git '.expand(g:vim_dir_path.'/plugged/vim-plug/autoload'))
  endif
endif

let g:plug_url_format = 'git@github.com:%s.git'
call plug#begin(expand(g:vim_dir_path.'/plugged'))

Plug 'junegunn/vim-plug', { 'dir': expand(vim_dir_path.'/plugged/vim-plug/autoload') }
Plug 'Shougo/vimproc',    { 'do': 'make' }             " 非同期実行ライブラリ
Plug 'Shougo/deoplete.nvim'                            " 入力補完機能
Plug 'roxma/nvim-yarp'                                 " Neovim用のリモートプラグインフレームワーク(deoplete用)
Plug 'roxma/vim-hug-neovim-rpc'                        " NeovimRPCクライアントの互換性レイヤー(deoplete用)
Plug 'Shougo/neosnippet'                               " スニペット展開
Plug 'honza/vim-snippets'                              " 各種snippet
Plug 'tpope/vim-repeat'                                " vim-surroundの機能を.反復
Plug 'tpope/vim-abolish'                               " 単語の複数の変種(キャメル,スネークなど)を簡単に検索,置換,短縮
Plug 'tpope/vim-surround'                              " text-object操作
Plug 'tpope/vim-fugitive'                              " fugitive(ステータスラインのブランチ名と,Gblame用)
Plug 'tpope/vim-rhubarb'                               " fugitiveのGbrowseでGithubを開く
Plug 'tpope/vim-abolish'                               " snake,camel,pascalケースなどを切り替える為に使用(その他の機能は使っていない)
Plug 'tpope/vim-eunuch'                                " ファイル操作
Plug 'junegunn/gv.vim'                                 " gitv(コミットログ閲覧用,vim-fugitive依存)
Plug 'hotwatermorning/auto-git-diff'                   " git-rebase-todoでコミットの内容を表示
Plug 'airblade/vim-gitgutter'                          " gitの差分を左端に表示
Plug 'tyru/open-browser.vim'                           " URIをブラウザで開く
Plug 'tyru/open-browser-github.vim'                    " githubをブラウザで開く
Plug 'kannokanno/previm'                               " markdownなどのプレビュー(open-browser依存)
Plug 'weirongxu/plantuml-previewer.vim'                " PlantUMLのプレビュー(open-browser,plantuml-syntax依存)
Plug 'rhysd/committia.vim'                             " コミットログ入力サポート
Plug 'rhysd/git-messenger.vim'                         " カーソル下のコミットメッセージを表示
Plug 'kana/vim-submode'                                " 連続入力などをサポートするサブモードを定義する
Plug 'kana/vim-textobj-user'                           " 独自text-object定義
Plug 'kana/vim-textobj-line'                           " lineのtext-object(vim-textobj-user依存)
Plug 'kana/vim-textobj-indent'                         " カーソル行と同じインデントのtext-object(vim-textobj-user依存)
Plug 'kana/vim-niceblock'                              " ビジュアル選択時にI,Aで行頭,行末に文字挿入
Plug 'terryma/vim-expand-region'                       " text-objectビジュアル選択
Plug 'vim-ruby/vim-ruby'                               " vim-ruby
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }     " vim-go
Plug 'posva/vim-vue'                                   " vim-vue
Plug 'digitaltoad/vim-pug'                             " vim-pug
Plug 'wavded/vim-stylus'                               " vim-stylus
Plug 'ngmy/vim-rubocop'                                " vim-rubocop
Plug 'hashivim/vim-terraform'                          " vim-terraform
Plug 'chrisbra/vim-zsh'                                " vim-zsh
Plug 'aklt/plantuml-syntax'                            " PlantUMLのシンタックス
Plug 'ynkdir/vim-vimlparser'                           " vimlのパーサー(構文解析)
Plug 'scrooloose/nerdtree'                             " ディレクトリツリーエクスプローラー
Plug 'Xuyuanp/nerdtree-git-plugin'                     " NERDTreeにgit statusの結果を反映
Plug 'w0rp/ale'                                        " 非同期シンタックスチェック
Plug 'tomtom/tcomment_vim'                             " コメントアウト
Plug 'itchyny/lightline.vim'                           " ステータスライン
Plug 'thinca/vim-prettyprint'                          " vimのデバッグ用prettyprint
Plug 'thinca/vim-quickrun'                             " バッファ上のソースコードを実行してvimへ出力
Plug 'thinca/vim-tabrecent'                            " 直前のタブに戻る
Plug 'osyo-manga/shabadou.vim'                         " 汎用的なquickrun-hook
Plug 'osyo-manga/vim-over'                             " 置換プレビュー
Plug 'easymotion/vim-easymotion'                       " 移動を簡単な動作で行う
Plug 'haya14busa/vim-edgemotion'                       " コードのエッジに移動する
Plug 'haya14busa/incsearch.vim'                        " インクリメンタルサーチ(vim-easymotion用)
Plug 'haya14busa/incsearch-fuzzy.vim'                  " インクリメンタルファジーサーチ(vim-easymotion用)
Plug 'haya14busa/incsearch-easymotion.vim'             " vim-easymotionとincsearch.vimを統合
Plug 'haya14busa/vim-asterisk'                         " *の動作を拡張
Plug 'haya14busa/vim-debugger'                         " vim script debugger
Plug 'fuenor/qfixgrep'                                 " プレビュー&絞り込み検索付きgrep
Plug 'skanehira/translate.vim'                         " Google翻訳
Plug 'glidenote/memolist.vim'                          " メモ管理
Plug 'kaneshin/ctrlp-memolist'                         " memolistをctrlpで絞り込む
Plug 'tmux-plugins/vim-tmux'                           " vim-tmux
Plug 't9md/vim-choosewin'                              " ウィンドウ対話的選択
Plug 'ctrlpvim/ctrlp.vim'                              " 多機能finder
Plug 'tacahiroy/ctrlp-funky'                           " ctrlpで関数を絞り込む
Plug 'jasoncodes/ctrlp-modified.vim'                   " ctrlpでgitで変更があったファイルを絞り込む
Plug 'dyng/ctrlsf.vim'                                 " 文字列検索
Plug 'godlygeek/tabular'                               " テキストフィルタリング
Plug 'plasticboy/vim-markdown'                         " vim-markdown(vim-tabular依存)
Plug 'fugalh/desert.vim'                               " カラースキーマ
Plug 'nathanaelkane/vim-indent-guides'                 " インデントガイド
Plug 'junegunn/vim-easy-align'                         " テキスト整形
Plug 'ludovicchabant/vim-gutentags'                    " ctags自動生成
Plug 'majutsushi/tagbar'                               " コード概要ビューア
Plug 'jiangmiao/auto-pairs'                            " 自動で閉じ記号を付与
Plug 'kshenoy/vim-signature'                           " マーカー表示
Plug 'adie/BlockDiff'                                  " BlockDiff(選択範囲の比較)
Plug 'LeafCage/yankround.vim'                          " ヤンク履歴管理
Plug 'Konfekt/FastFold'                                " 自動折畳
Plug 'vim-scripts/AnsiEsc.vim'                         " ANSIカラー表示
Plug 'yami-beta/vim-responsive-tabline'                " タブの横幅を調整
Plug 'vim/killersheep'                                 " killersheep
Plug 'ToruIwashita/tab-relocator.vim'                  " タブ移動補助
Plug 'ToruIwashita/nimble-anyjump.vim'                 " タグジャンプ,ファイル名ジャンプ,URLジャンプ補助
Plug 'ToruIwashita/window-closer.vim'                  " ウィンドウを閉じる動作の制御
Plug 'ToruIwashita/cursor-position-memento.vim'        " カーソル位置の保存・復元
Plug 'ToruIwashita/simple-git-commands.vim'            " gitのシンプルなコマンド群
Plug 'ToruIwashita/add-git-managed-file-to-buffer.vim' " untracked, modified, changedなファイルをバッファにのせる
Plug 'ToruIwashita/git-switcher.vim'                   " git管理プロジェクトのセッション切り替え

call plug#end()

"" 各種設定読込
if filereadable(expand(g:vim_dir_path.'/config.vim')) | exec 'source' expand(g:vim_dir_path.'/config.vim') | en
if filereadable(expand(g:vim_dir_path.'/config.plugin.vim')) | exec 'source' expand(g:vim_dir_path.'/config.plugin.vim') | en
if filereadable(expand(g:vim_dir_path.'/config.local.vim')) | exec 'source' expand(g:vim_dir_path.'/config.local.vim') | en

"" 色設定
" Visual Mode
hi! Visual ctermfg=yellow ctermbg=black
