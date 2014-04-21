## stty画面出力停止無効
stty stop undef

## オプション設定
# ビープ音なし
setopt no_beep
# 自動CD
setopt auto_cd
# 自動的にディレクトリスタックにカレントディレクトリ追加
setopt auto_pushd
# 引数の無いpushdは$HOMEをスタックする
setopt pushd_to_home
# 重複ディレクトリはスタックしない
setopt pushd_ignore_dups
# PROMPT変数に対して変数等展開
setopt prompt_subst
# ファイル補完種類表示
setopt list_types
# 補完候補を一覧表示
setopt auto_list
# 候補が複数ある時直ちにメニュー補完に移行
setopt menu_complete
# オプション指定時"="以降も補完
setopt magic_equal_subst
# カッコの対応などを自動的に補完
setopt auto_param_keys
# 単語途中の補完
setopt complete_in_word
# ディレクトリ名の補完で末尾の"/"を自動的に付加
setopt auto_param_slash
# スペースで /を削除
setopt auto_remove_slash
# 補完のときプロンプトの位置を変えない
setopt always_last_prompt
# 補完候補を詰めて表示
setopt list_packed
# ファイル名の展開でディレクトリにマッチした場合末尾に"/"を付加
setopt mark_dirs
# コマンドラインでも"#"以降をコメントと見なす
setopt interactive_comments
# 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
# 重複コマンド記録しない(古い行を消して新しい行を追加)
setopt hist_ignore_all_dups
# コマンド履歴・共有
setopt share_history
# コマンド履歴・シェル横断実行時間順ヒストリ保存
setopt incappend_history
# コマンド履歴・コマンド実行時間保存
setopt extended_history
# historyコマンドを記録しない
setopt hist_no_store
# 余分なスペースは保存しない
setopt hist_reduce_blanks
# 行頭がスペースで始まるコマンドを記録しない
setopt hist_ignore_space
# 拡張ファイルグロブを有効にする
setopt extended_glob
# ファイル名を数値としてソート
setopt numeric_glob_sort
# 複数リダイレクト記述有効
setopt multios
# リダイレクト時既に存在するファイル上書きエラー
setopt no_clobber
# フローコントロール無効
setopt no_flow_control

## コマンド履歴
# メモリに展開する履歴数
HISTSIZE=100000
# 保存する履歴数
SAVEHIST=100000

## vimモードキーマップ
# Ctr+Aで行頭へ
bindkey -v '^A' beginning-of-line
# Ctr+Bで１文字左へ
bindkey -v '^B' backward-char
# Ctr+Dで１文字削除
bindkey -v '^D' delete-char-or-list
# Ctr+Eで行末へ
bindkey -v '^E' end-of-line
# Ctr+Fで１文字右へ
bindkey -v '^F' forward-char
# Ctr+Gで入力キャンセル
bindkey -v '^G' send-break
# Ctr+Kで行末まで削除
bindkey -v '^K' kill-line
# Ctr+Nで１行下へ
bindkey -v '^N' down-line-or-history
# Ctr+Pで１行上へ
bindkey -v '^P' up-line-or-history
# Ctr+Rでインクリメンタルサーチ
bindkey -v '^R' history-incremental-search-backward
# Ctr+Yでコマンドラインスタック(push-lineでも良いが複数行を考慮するとpush-inputの方が良い)
bindkey -v '^Y' push-input
# Ctr+Uでkill-word
bindkey -v '^U' kill-word
# Ctr+vでstart-vim
bindkey -v '^V' start-vim
# Ctr+Wでbackward-kill-word
bindkey -v '^W' backward-kill-word
# Ctr+_でcdup
bindkey -v "^_" cdup
# Shift+tabで逆タブ補完
bindkey -v "^[[Z" reverse-menu-complete
## 補完メニュー選択モードキーマップ
# Ctr+Bで左へ
bindkey -M menuselect '^B' backward-char
# Ctr+Fで右へ
bindkey -M menuselect '^F' forward-char
# Ctr+Nで下へ
bindkey -M menuselect '^N' down-line-or-history
# Ctr+Pで上へ
bindkey -M menuselect '^P' up-line-or-history
# Ctr+Kで次の補完メニュー
bindkey -M menuselect '^K' accept-and-infer-next-history
# Ctr+Jで実行を２回
bindkey -M menuselect '^J' double-accept-line

## エイリアス
# ZMV
alias zmv='noglob zmv -W'
# VIM
alias v="vim"
# OTHER
alias ez="exec zsh"
alias cp="cp -ip"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls -F --color"
alias l="ls"
alias c="cat"
alias grep="grep --color"
alias his="history -50n"
alias tm="tmux -2"
alias tigb="tig blame"
# CD
alias d="cd"
alias cdz="cd ~/.zsh.d"
alias cdv="cd ~/.vim"
alias cdl="cd ~/local"
alias cds="cd ~/src"
alias cdsz="cd ~/src/zsh"
alias cdsv="cd ~/src/vim"
# GIT
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gf="git fetch"
alias gs="git status"
alias gl="git log"
alias gla="git log --graph --all --pretty='%x09%h %cn%x09%s %Cred%d%Creset'"
# TIG
alias tigb="tig blame"
alias tigs="tig status"
# APACHE
alias ap_err="tailf /var/log/httpd/error_log"
alias ap_acc="tailf /var/log/httpd/access_log"

