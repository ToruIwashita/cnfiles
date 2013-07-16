### メモ
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

####・GNU系コマンド
``ls``については``coreutils``をMacにインストール  

    $ brew install coreutils  

GNU版``ls``の``gls``と``gdircolors``が使用可能  

``find``,``xargs``については``findutils``をMacにインストール  

    $ brew install findutils

GNU版``find``,``xargs``の``gfing``と``gxargs``が使用可能  

※それぞれaliasを設定するのがオススメ

####・gitのデフォルトエディタをvimに  
``.gitconfig``に以下の記述を追加  

    [core]    
      editor = vim    

####・git log-all  
``.gitconfig``に以下の``alias``追加

    [alias]    
      log-all = log --graph --all --color --pretty='%x09%h %cn%x09%s %Cred%d%Creset'  

####・CUI Gitブラウザ``tig``
Macにインストール

    $ brew install tig

``yum``があるLinux環境にインストール

    $ yum install tig
  
  
※注意：``tig``デフォルトキーバインドの'G'で``git gc``が走るため、以下の設定を``.gitconfig``に追加する方が良い

    [tig "bind"]
      generic = g move-first-line
      generic = G move-last-line

####・文字コード変換``nkf``
Macにインストール  

    $ brew install nkf  

``yum``があるLinux環境にインストール

    $ yum install nkf

####・Markdown文章編集  
``w3m``をインストール  

    $ yum install w3m  


後は``markdown``コマンドが使える状態のzshコマンドラインで

    $ w3m -T text/html =(markdown hoge.md)

#####・依存関係メモ  
``zsh`` ``tmux`` ``vim`` ``git`` ``mysql``
