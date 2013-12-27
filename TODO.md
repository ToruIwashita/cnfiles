### TODOメモ  

0.`vim`最新版をインストールする手順確立  
1.`git reset HEAD`でUnstagedする関数  
2.`tig`で作業する用の`pane`作成  
3.`tig`用ブランチ名の補完を作成(もしくは`git log`に)  
4.`vim`の`ruby`用スニペットを自作  
5.`vim`の`skeleton`を追加して雛形を読み込む  
6.`zsh`の`usage`を`git`に合わせる(オプション引数,必須引数など)  

#### メモ  

0.`Cocoa`  
1.`vim`の`mark`機能関連のプラグイン作成  
2.`mysql`の`Deadlock`の情報収集  
3.`REST`指向,`CURD`についてまとめる  

e.g.) ある環境の`vim --version`１  

    VIM - Vi IMproved 7.2 (2008 Aug 9, compiled Jul 28 2011 09:50:06)    
    適用済パッチ: 1-411    
    Modified by <bugzilla@redhat.com>    
    Compiled by <bugzilla@redhat.com>    
    Huge 版 without GUI.  機能の一覧 有効(+)/無効(-)    
    +arabic        +autocmd        -balloon_eval   -browse        ++builtin_terms  +byte_offset  +cindent    
    -clientserver  -clipboard      +cmdline_compl  +cmdline_hist  +cmdline_info    +comments    
    +cryptv        +cscope         +cursorshape    +dialog_con    +diff            +digraphs     -dnd          -ebcdic    
    +emacs_tags    +eval           +ex_extra       +extra_search  +farsi           +file_in_path +find_in_path    
    +float         +folding        -footer         +fork()        +gettext         -hangul_input +iconv        +insert_expand    
    +jumplist      +keymap         +langmap        +libcall       +linebreak       +lispindent   +listcmds     +localmap    
    +menu          +mksession      +modify_fname   +mouse         -mouseshape      +mouse_dec    +mouse_gpm    
    -mouse_jsbterm +mouse_netterm  -mouse_sysmouse +mouse_xterm   +multi_byte    
    +multi_lang    -mzscheme       -netbeans_intg  -osfiletype    +path_extra      +perl         +postscript    
    +printer       +profile        +python         +quickfix      +reltime         +rightleft    -ruby         +scrollbind    
    +signs         +smartindent    -sniff          +startuptime   +statusline      -sun_workshop +syntax    
    +tag_binary    +tag_old_static -tag_any_white  -tcl           +terminfo        +termresponse    
    +textobjects   +title          -toolbar        +user_commands +vertsplit       +virtualedit  +visual    
    +visualextra   +viminfo        +vreplace       +wildignore    +wildmenu        +windows      +writebackup    
    -X11           -xfontset       -xim            -xsmp          -xterm_clipboard -xterm_save    
          システム vimrc: "/etc/vimrc"    
            ユーザ vimrc: "$HOME/.vimrc"    
             ユーザ exrc: "$HOME/.exrc"    
           省略時の $VIM: "/usr/share/vim"    
    コンパイル: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -O2 -g -pipe -Wall  -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mt    
    NU_SOURCE -D_FILE_OFFSET_BITS=64  -D_FORTIFY_SOURCE=1    -D_REENTRANT -D_GNU_SOURCE  -fstack-protector -I/usr/local/include -D_LARGEFILE    
    OFFSET_BITS=64  -I/usr/lib64/perl5/CORE  -I/usr/include/python2.6 -pthread    
    リンク: gcc   -Wl,-E -Wl,-rpath,/usr/lib64/perl5/CORE   -L/usr/local/lib -o vim       -lncurses -lacl -lgpm   -Wl,-E -Wl,-rpath,/usr/lib    
    fstack-protector  -L/usr/lib64/perl5/CORE -lperl -lresolv -lutil -lc -L/usr/lib64/python2.6/config -lpython2.6 -lutil -lm -Xlinker -expo    


e.g.) ある環境の`vim --version`２  

オプションは以下  
`> ./configure --prefix=/mnt/tmp/ --enable-multibyte --enable-rubyinterp --with-ruby-command=/usr/bin/ruby`  

    VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Dec 27 2013 10:21:53)    
    適用済パッチ: 1-131    
    Compiled by webuser@ip-10-156-86-112    
    通常 版 without GUI.  機能の一覧 有効(+)/無効(-)    
    +acl             -farsi           -mouse_netterm   +syntax    
    -arabic          +file_in_path    -mouse_sgr       +tag_binary    
    +autocmd         +find_in_path    -mouse_sysmouse  +tag_old_static    
    -balloon_eval    +float           -mouse_urxvt     -tag_any_white    
    -browse          +folding         +mouse_xterm     -tcl    
    +builtin_terms   -footer          +multi_byte      +terminfo    
    +byte_offset     +fork()          +multi_lang      +termresponse    
    +cindent         +gettext         -mzscheme        +textobjects    
    +clientserver    -hangul_input    +netbeans_intg   +title    
    +clipboard       +iconv           +path_extra      -toolbar    
    +cmdline_compl   +insert_expand   -perl            +user_commands    
    +cmdline_hist    +jumplist        +persistent_undo +vertsplit    
    +cmdline_info    -keymap          +postscript      +virtualedit    
    +comments        -langmap         +printer         +visual    
    -conceal         +libcall         -profile         +visualextra    
    +cryptv          +linebreak       -python          +viminfo    
    -cscope          +lispindent      -python3         +vreplace    
    +cursorbind      +listcmds        +quickfix        +wildignore    
    +cursorshape     +localmap        +reltime         +wildmenu    
    +dialog_con      -lua             -rightleft       +windows    
    +diff            +menu            +ruby            +writebackup    
    +digraphs        +mksession       +scrollbind      +X11    
    -dnd             +modify_fname    +signs           +xfontset    
    -ebcdic          +mouse           +smartindent     -xim    
    -emacs_tags      -mouseshape      -sniff           +xsmp_interact    
    +eval            -mouse_dec       +startuptime     +xterm_clipboard    
    +ex_extra        -mouse_gpm       +statusline      -xterm_save    
    +extra_search    -mouse_jsbterm   -sun_workshop    +xpm    
          システム vimrc: "$VIM/vimrc"    
            ユーザ vimrc: "$HOME/.vimrc"    
         第2ユーザ vimrc: "~/.vim/vimrc"    
             ユーザ exrc: "$HOME/.exrc"    
           省略時の $VIM: "/mnt/tmp/share/vim"    
    コンパイル: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1    
    リンク: gcc   -L. -m64 -rdynamic -Wl,-export-dynamic  -L/usr/local/lib -Wl,--as-needed -o vim    -lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM -lICE  -lm -ltinfo -lnsl  -lselinux       -L/usr/lib64/ruby/1.9 -lruby -lpthread -lrt -ldl -lcrypt -lm    
