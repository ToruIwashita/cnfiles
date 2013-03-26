### メモ
* ``ls``について  

GNU系コマンド集``coreutils``をMacにインストール  
    ``$ brew install coreutils``  
GNU版``ls``の``gls``と``gdircolors``が使用可能  

* ``git log-all``  

``.gitconfig``に以下の``alias``追加  
    ``log-all = log --graph --all --color --pretty='%x09%h %cn%x09%s %Cred%d%Creset'``  

* CUI Gitブラウザ``tig``

Macにインストール
    ``brew install tig``
yumがあるLinux環境にインストール
    ``yum install tig``
※注意：tigのデフォルトkeybindの'G'でgit gcが走るため、以下の設定を.gitconfigに追加する方が良い

``[tig "bind"]
        generic = g move-first-line
        generic = G move-last-line``
