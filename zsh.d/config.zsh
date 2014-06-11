## stty画面出力停止無効
stty stop undef

## オプション設定
setopt no_beep               # ビープ音なし
setopt auto_cd               # 自動CD
setopt auto_pushd            # 自動的にディレクトリスタックにカレントディレクトリ追加
setopt pushd_to_home         # 引数の無いpushdは$HOMEをスタックする
setopt pushd_ignore_dups     # 重複ディレクトリはスタックしない
setopt prompt_subst          # PROMPT変数に対して変数等展開
setopt list_types            # ファイル補完種類表示
setopt auto_list             # 補完候補を一覧表示
setopt menu_complete         # 候補が複数ある時直ちにメニュー補完に移行
setopt magic_equal_subst     # オプション指定時"="以降も補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt complete_in_word      # 単語途中の補完
setopt auto_param_slash      # ディレクトリ名の補完で末尾の"/"を自動的に付加
setopt auto_remove_slash     # スペースで /を削除
setopt always_last_prompt    # 補完のときプロンプトの位置を変えない
setopt list_packed           # 補完候補を詰めて表示
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合末尾に"/"を付加
setopt interactive_comments  # コマンドラインでも"#"以降をコメントと見なす
setopt noautoremoveslash     # 最後のスラッシュを自動的に削除しない
setopt hist_ignore_all_dups  # 重複コマンド記録しない(古い行を消して新しい行を追加)
setopt share_history         # コマンド履歴・共有
setopt incappend_history     # コマンド履歴・シェル横断実行時間順ヒストリ保存
setopt extended_history      # コマンド履歴・コマンド実行時間保存
setopt hist_no_store         # historyコマンドを記録しない
setopt hist_reduce_blanks    # 余分なスペースは保存しない
setopt hist_ignore_space     # 行頭がスペースで始まるコマンドを記録しない
setopt extended_glob         # 拡張ファイルグロブを有効にする
setopt numeric_glob_sort     # ファイル名を数値としてソート
setopt multios               # 複数リダイレクト記述有効
setopt no_clobber            # リダイレクト時既に存在するファイル上書きエラー
setopt no_flow_control       # フローコントロール無効

## コマンド履歴
HISTFILE=~/.zsh_history  # ヒストリファイル
HISTSIZE=100000          # メモリに展開する履歴数
SAVEHIST=100000          # 保存する履歴数

## vimモードキーマップ
bindkey -v '^a' beginning-of-line                    # Ctr+aで行頭へ
bindkey -v '^b' backward-char                        # Ctr+bで１文字左へ
bindkey -v '^d' delete-char-or-list                  # Ctr+dで１文字削除
bindkey -v '^e' end-of-line                          # Ctr+eで行末へ
bindkey -v '^f' forward-char                         # Ctr+fで１文字右へ
bindkey -v '^g' send-break                           # Ctr+gで入力キャンセル
bindkey -v '^j' accept-line                          # Ctr+jで入力実行
bindkey -v '^k' kill-line                            # Ctr+kで行末まで削除
bindkey -v '^n' down-line-or-history                 # Ctr+nで１行下へ
bindkey -v '^o' into-dir-and-push-remains-to-prompt  # Ctr+oでバッファ残しディレクトリ移動
bindkey -v '^p' up-line-or-history                   # Ctr+pで１行上へ
bindkey -v '^r' history-incremental-search-backward  # Ctr+rでインクリメンタルサーチ
bindkey -v '^y' push-input                           # Ctr+yでコマンドラインスタック(複数行を考慮してpush-inputに設定)
bindkey -v '^u' kill-word                            # Ctr+uでkill-word
bindkey -v '^l' start-editor                         # Ctr+vでstart-editor
bindkey -v '^q' self-insert                          # Ctr+qでself-insert
bindkey -v '^w' backward-kill-word                   # Ctr+wでbackward-kill-word
bindkey -v '^s^l' edit-command-line                  # Ctr+s,Ctr+lでコマンドライン編集
bindkey -v '^@' clear-screen                         # Ctr+@でclear-screen
bindkey -v "^_" cdup                                 # Ctr+_でcdup
bindkey -v "^[[Z" reverse-menu-complete              # Shift+tabで逆タブ補完
## 補完メニュー選択モードキーマップ
bindkey -M menuselect '^b' backward-char                  # Ctr+Bで左へ
bindkey -M menuselect '^f' forward-char                   # Ctr+Fで右へ
bindkey -M menuselect '^g' double-send-break              # Ctr+Gでsend-break2回
bindkey -M menuselect '^n' down-line-or-history           # Ctr+Nで下へ
bindkey -M menuselect '^p' up-line-or-history             # Ctr+Pで上へ
bindkey -M menuselect '^k' accept-and-infer-next-history  # Ctr+Kで次の補完メニュー
bindkey -M menuselect '^j' double-accept-line             # Ctr+Jでaccept-line２回

## エイリアス
# gnu command
if type gls > /dev/null 2>&1; then
  alias ls="gls -F --color"
else
  alias ls="ls -F --color"
fi
if type gfind > /dev/null 2>&1; then
  alias find="gfind"
fi
if type gxargs > /dev/null 2>&1; then
  alias xargs="gxargs"
fi
# zmv
alias zmv='noglob zmv -W'
# vim
alias v="vim"
# tmux
alias tm="tmux -2"
# other
alias ez="exec zsh"
alias cp="cp -ip"
alias mv="mv -i"
alias rm="rm -i"
alias l="ls"
alias c="cat"
alias grep="grep --color"
alias less="less -R"
alias his="history -f"
alias curh="curl --head"
# cd
alias d="cd"
alias cdz="cd ~/.zsh.d"
alias cdv="cd ~/.vim"
alias cdl="cd ~/local"
alias cds="cd ~/src"
alias cdsz="cd ~/src/zsh"
alias cdsv="cd ~/src/vim"
alias cdst="cd ~/src/tmux"
# git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gf="git fetch"
alias gs="git status -s"
alias gl="git log"
alias gla="git log --graph --all --pretty='%x09%h %cn%x09%s %Cred%d%Creset'"
