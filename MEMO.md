### メモ
####・``iTerm2``

    http://www.iterm2.com/#/section/home

####・``ls``について  

GNU系コマンド集``coreutils``をMacにインストール

    $ brew install coreutils  

GNU版``ls``の``gls``と``gdircolors``が使用可能  

####・``git log-all``  

``.gitconfig``に以下の``alias``追加

    log-all = log --graph --all --color --pretty='%x09%h %cn%x09%s %Cred%d%Creset'  

####・CUI Gitブラウザ``tig``

Macにインストール

    brew install tig

``yum``があるLinux環境にインストール

    yum install tig
  
  
※注意：``tig``デフォルトキーバインドの'G'で``git gc``が走るため、以下の設定を``.gitconfig``に追加する方が良い

    [tig "bind"]
        generic = g move-first-line
        generic = G move-last-line
