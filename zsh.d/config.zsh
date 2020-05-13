stty stop undef  # <C-s>入力での画面への出力停止を無効化
stty eof undef   # <C-d>でのeof入力を無効化

## built-inコマンドのrを無効化
disable r

## オプション設定
setopt nobeep               # ビープ音なし
setopt notify               # バックグラウンドジョブの状態を即時通知
setopt autocd               # 自動CD
setopt autopushd            # 自動的にディレクトリスタックにカレントディレクトリ追加
setopt pushdtohome          # 引数の無いpushdは$HOMEをスタックする
setopt pushdignoredups      # 重複ディレクトリはスタックしない
setopt promptsubst          # PROMPT変数に対して変数等展開
setopt listtypes            # ファイル補完種類表示
setopt autolist             # 補完候補を一覧表示
setopt menucomplete         # 候補が複数ある時直ちにメニュー補完に移行
setopt magicequalsubst      # オプション指定時"="以降も補完
setopt autoparamkeys        # カッコの対応などを自動的に補完
setopt completeinword       # 単語途中の補完
setopt autoparamslash       # ディレクトリ名の補完で末尾の"/"を自動的に付加
setopt alwayslastprompt     # 補完のときプロンプトの位置を変えない
setopt listpacked           # 補完候補を詰めて表示
setopt markdirs             # ファイル名の展開でディレクトリにマッチした場合末尾に"/"を付加
setopt interactivecomments  # コマンドラインでも"#"以降をコメントと見なす
setopt noautoremoveslash    # 最後のスラッシュを自動的に削除しない
setopt histignoredups       # 重複コマンド記録しない(古い行を消して新しい行を追加)
setopt sharehistory         # コマンド履歴・共有
setopt incappendhistory     # コマンド履歴・シェル横断実行時間順ヒストリ保存
setopt extendedhistory      # コマンド履歴・コマンド実行時間保存
setopt histnostore          # historyコマンドを記録しない
setopt histreduceblanks     # 余分なスペースは保存しない
setopt incappendhistory     # 履歴をインクリメンタルに追加(履歴が即書き込まれる)
setopt histignorespace      # 行頭がスペースで始まるコマンドを記録しない
setopt extendedglob         # 拡張ファイルグロブを有効にする
setopt numericglobsort      # ファイル名を数値としてソート
setopt nonomatch            # グロブパターンにマッチしない場合は標準エラー出力する
setopt multios              # 複数リダイレクト記述有効
setopt noclobber            # リダイレクト時既に存在するファイル上書きエラー
setopt noflowcontrol        # フローコントロール無効(C-s,C-qのフローコントロールがなくなるので,^sのプレフィックスが使える)

## bindkey
# vimモードキーマップ
bindkey -v '^a' beginning-of-line                       # Ctrl+aで行頭へ
bindkey -v '^b' backward-char                           # Ctrl+bで1文字左へ(menuselectも同様)
bindkey -v '^d' delete-char-or-list                     # Ctrl+dで1文字削除
bindkey -v '^e' end-of-line                             # Ctrl+eで行末へ
bindkey -v '^f' forward-char                            # Ctrl+fで1文字右へ(menuselectも同様)
bindkey -v '^g' send-break                              # Ctrl+gで入力キャンセル
bindkey -v '^h' backward-delete-char                    # Ctrl+hでbackward-delete-char(menuselectのinteractive-modeでbackword)
bindkey -v '^i' expand-or-complete                      # Ctrl+iで通常補完
bindkey -v '^j' accept-line                             # Ctrl+jでaccept-line
bindkey -v '^m' accept-line                             # Ctrl+mでaccept-line
bindkey -v '^q' self-insert                             # Ctrl+qでself-insert
bindkey -v '^r' history-incremental-search-backward     # Ctrl+rでインクリメンタルサーチ
bindkey -v '^s' self-insert                             # Ctrl+sでself-insert,Prefixとして使用
bindkey -v '^u' kill-word                               # Ctrl+uでkill-word
bindkey -v '^w' backward-kill-word                      # Ctrl+wでbackward-kill-word
bindkey -v '^y' push-input                              # Ctrl+yでコマンドラインスタック(複数行を考慮してpush-inputに設定)
bindkey -v '^z' run-fg-last                             # Ctrl+zで最後にサスペンドしたjobに復帰する
bindkey -v '^sf' peco-file-find-and-start-editor        # Ctrl+s,fでファイル検索してstart-editor
bindkey -v '^sg' immediate-hub-browse                   # Ctrl+s,gでhub browse
bindkey -v '^sh' immediate-git-log-search               # Ctrl+s,hでgit log検索
bindkey -v '^sj' vi-join                                # Ctrl+s,jでviのjoin
bindkey -v '^sk' peco-cd-recent-dir                     # Ctrl+s,kで最近移動したディレクトリを絞り込んで移動
bindkey -v '^sl' edit-command-line                      # Ctrl+s,lでコマンドラインエディタ編集
bindkey -v '^sn' immediate-git-fetch                    # Ctrl+s,nでgit fetch
bindkey -v '^so' peco-cd-dir                            # Ctrl+s,oでディレクトリを絞り込んで移動
bindkey -v '^sp' immediate-git-pull                     # Ctrl+s,pでgit pull
bindkey -v '^ss' peco-ag-and-start-editor               # Ctrl+s,sでagで検索してstart-editorCtr+s
bindkey -v '^su' immediate-git-diff                     # Ctrl+s,uでgit diff
bindkey -v '^sw' stash-restore-rprompt                  # Ctrl+s,wで退避したRPROMPTを復元
bindkey -v '^s@' clear-screen                           # Ctrl+@でclear-screen
bindkey -v '^s;' peco-cd-ghq-repo                       # Ctrl+s,;でghq管理下のリポジトリを絞り込んで移動
bindkey -v '^s,' google-search                          # Ctrl+s,,でコマンドラインの文字列を使ったGoogle検索
bindkey -v '^s.' gtran-ja-to-en                         # Ctrl+s,.で日本語を英語に翻訳
bindkey -v '^s/' gtran-en-to-ja                         # Ctrl+s,/で英語を日本語に翻訳
bindkey -v '^s^a' immediate-git-add-all                 # Ctrl+s,Ctrl+aでgit add .
bindkey -v '^s^f' peco-file-finder                      # Ctrl+s,Ctrl+fでpeco-file-finder
bindkey -v '^s^g' immediate-hub-browse-pull-request     # Ctrl+s,Ctrl+gでブランチ名からpull requestを開く
bindkey -v '^s^h' immediate-git-log-search-with-diff    # Ctrl+s,Ctrl+hでgit logをdiff出力付きで検索
bindkey -v '^s^p' copy-prev-shell-word                  # Ctrl+s,Ctrl+pで1つ前の文字列をコピペ(空欄区切りで文字列判定)
bindkey -v '^s^r' immediate-git-reset-all               # Ctrl+s,Ctrl+rでgit reset
bindkey -v '^s^s' peco-git-grep-and-start-editor        # Ctrl+s,Ctrl+sでgit grepしてstart-editor
bindkey -v '^s^u' immediate-git-status                  # Ctrl+s,Ctrl+uでgit status
bindkey -v '^s^w' stash-save-rprompt                    # Ctrl+s,Ctrl+wでRPROMPTを退避
bindkey -v '^s^z' run-fg-last-with-up-line-or-history   # Ctrl+s,Ctrl+zで履歴を逆上る+最後にサスペンドしたjobに復帰する
bindkey -v '^s^]' vi-backward-word                      # Ctrl+s,Ctrl+]で前の単語の先頭に移動
bindkey -v '^s^@' kill-line                             # Ctrl+s,Ctrl+@でカーソル行以降削除
bindkey -v '^]' vi-forward-word                         # Ctrl+]で次の単語の先頭に移動
bindkey -v '^?' backward-delete-char                    # BSでbackward-delete-char(menuselectのinteractive-modeでbackword)

## alias
# cd
alias cdz="cd $ZSH_DIR_PATH"
alias cdv="cd $VIM_DIR_PATH"
alias cdl="cd $LOCAL_DIR_PATH"
alias cdw="cd $WORKS_DIR_PATH"
alias cdt="cd $TMP_DIR_PATH"
alias cdc="cd $CNFILES_DIR_PATH"
alias cdm="cd $MARKDOWN_TEXTS_DIR_PATH"
alias cdml="cd $MEMOLIST_DIR_PATH"
# zmv
alias zmv='noglob zmv -W'
# vim
alias v='vim'
# tmux
alias tm='tmux -2'
# ls
alias ls='ls -F --color'
alias l='ls -ahl'
alias wl='watch "ls -al"'
# cd
alias d='cd'
alias dr='cdr'
# tar
alias totar='tar cvf'
alias untar='tar xvf'
# history
alias his='history -f'
alias his-all='history -E 1'
# git
alias ga='git add'
alias gb='git branch'
alias gf='git fetch --prune'
alias gp='git prune'
alias gl='git log'
alias gs='git status'
alias gss='git stash save'
alias gsp='git stash pop'
# ping
alias ping-one='ping -v -c 1'
# other
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'
alias c='cat'
alias so='source'
alias grep='grep --color'
alias less='less -R'
alias tailf='tail -f'
# memolist
alias -g TT=">! $MEMOLIST_TMP_TEXT_FILE_PATH"
