### メモ  
***  
####・iTerm2  

    http://www.iterm2.com/#/section/home    

Font: 13pt Menlo regular  
Character Spacing Horizontal: 0.8 Vertical: 0.9  
Preferences > General > Save copy/paste でペースト履歴をディスクに保存 
  
##### iTerm2機能  
ペースト履歴  
``cmd+shift+h``  
インスタントリプレイ  
``cmd+opt+b``  

***  
####・`ruby`オプションが有効な`vim`か調べる  

     $ vim --version | grep ruby    
     -python3 +quickfix +reltime -rightleft -ruby +scrollbind +signs +smartindent    

　=> `+ruby`ならばオプション有効  

***  
####・GNU系コマンド  
``ls``については``coreutils``をMacにインストール  

    $ brew install coreutils    

GNU版``ls``の``gls``と``gdircolors``が使用可能  

``find``,``xargs``については``findutils``をMacにインストール  

    $ brew install findutils    

GNU版``find``,``xargs``の``gfing``と``gxargs``が使用可能  

※それぞれaliasを設定するのがオススメ  

***  
####・NeoBundle  
`vim`のプラグイン管理ツール  
以下を実施して導入  

    $ mkdir -p ~/.vim/bundle    
    $ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim    

`.vimrc`に以下を追記  

    set nocompatible    
    filetype off    
    if has('vim_starting')    
      set runtimepath+=~/.vim/bundle/neobundle.vim/    
    endif    
    call neobundle#rc(expand('~/.vim/bundle/'))    
    
    NeoBundleFetch 'Shougo/neobundle.vim' # NeoBundle自身をNeoBundleで管理    
    NeoBundle 'Shougo/vimproc'            
    NeoBundle 'Shougo/vimproc', {         # 非同期処理を可能にするプラグイン(インストール推奨)    
    \  'build' : {    
    \    'mac' : 'make -f make_mac.mak',    
    \    'unix' : 'make -f make_unix.mak',    
    \  },    
    \}    
    NeoBundle '#任意のプラグイン'    
    ...    
    
    filetype plugin indent on    

任意のプラグインを記述したら`vim`を開いて`:NeoBundleInstall`を実行するとプラグインが`~/.vim/bundle/`以下にインストールされる  

※ 注意:`vimproc`は`NeoBundleInstall`後にビルドが必要な場合がある  

    $ cd ~/.vim/bundle/vimproc    
    $ make -f make_unix.mak    

　Macなら`make_mac.mak`を使用する  

***  
####・gitのデフォルトエディタをvimに  
``.gitconfig``に以下の記述を追加  

    [core]    
      editor = vim    

####・git log-all  
``.gitconfig``に以下の``alias``追加  

    [alias]    
      log-all = log --graph --all --color --pretty='%x09%h %cn%x09%s %Cred%d%Creset'    

***  
####・CUI Gitブラウザ``tig``  
Macにインストール  

    $ brew install tig    

``yum``があるLinux環境にインストール  

    $ yum install tig    
  
  
※注意：``tig``デフォルトキーバインドの'G'で``git gc``が走るため、以下の設定を``.gitconfig``に追加する方が良い  

    [tig "bind"]    
      generic = g move-first-line    
      generic = G move-last-line    

オススメ`alias`  
    alias tigb="tig blame"    

***  
####・文字コード変換``nkf``  
Macにインストール  

    $ brew install nkf    

``yum``があるLinux環境にインストール  

    $ yum install nkf    

***  
####・Markdown文章編集  
``w3m``をインストール  

    $ yum install w3m    


後は``markdown``コマンドが使える状態のzshコマンドラインで  

    $ w3m -T text/html =(markdown hoge.md)

***  
#####・依存関係メモ  
``zsh`` ``tmux`` ``vim`` ``git`` ``mysql``  
