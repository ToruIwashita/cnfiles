## stty画面出力停止無効
stty stop undef

## コマンド履歴
HISTFILE=~/.zsh_history  # ヒストリファイル
HISTSIZE=100000          # メモリに展開する履歴数
SAVEHIST=100000          # 保存する履歴数

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
setopt nonomatch             # グロブパターンにマッチしない場合は標準エラー出力する
setopt multios               # 複数リダイレクト記述有効
setopt no_clobber            # リダイレクト時既に存在するファイル上書きエラー
setopt no_flow_control       # フローコントロール無効

## bindkey
# vimモードキーマップ
bindkey -v '^a' beginning-of-line                    # Ctr+aで行頭へ
bindkey -v '^b' backward-char                        # Ctr+bで１文字左へ
bindkey -v '^d' delete-char-or-list                  # Ctr+dで１文字削除
bindkey -v '^e' end-of-line                          # Ctr+eで行末へ
bindkey -v '^f' forward-char                         # Ctr+fで１文字右へ
bindkey -v '^g' send-break                           # Ctr+gで入力キャンセル
bindkey -v '^h' backward-delete-char                 # Ctr+hでbackward
bindkey -v '^i' expand-or-complete                   # Ctr+iで通常補完
bindkey -v '^j' accept-line                          # Ctr+jでaccept-line
bindkey -v '^k' interactive-complete-files           # Ctr+kでファイルインタラクティブ補完
bindkey -v '^l' start-editor                         # Ctr+lでstart-editor
bindkey -v '^m' accept-line                          # Ctr+mでaccept-line
bindkey -v '^n' history-substring-search-down        # Ctr+nで部分文字列検索,下
bindkey -v '^o' into-dir-and-push-remains-to-prompt  # Ctr+oでバッファ残しディレクトリ移動
bindkey -v '^p' history-substring-search-up          # Ctr+pで部分文字列検索,上
bindkey -v '^q' self-insert                          # Ctr+qでself-insert
bindkey -v '^r' history-incremental-search-backward  # Ctr+rでインクリメンタルサーチ
bindkey -v '^s' self-insert                          # Ctr+sでself-insert,Prefixとして使用
bindkey -v '^u' kill-word                            # Ctr+uでkill-word
bindkey -v '^w' backward-kill-word                   # Ctr+wでbackward-kill-word
bindkey -v '^y' push-input                           # Ctr+yでコマンドラインスタック(複数行を考慮してpush-inputに設定)
bindkey -v '^sj' cat-current                         # Ctr+s,jでBUFFERをcat
bindkey -v '^sk' ls-current                          # CTr+s,kでls
bindkey -v '^sl' edit-command-line                   # Ctr+s,lでBUFFERをエディタ編集
bindkey -v '^s^j' cat-current                        # Ctr+s,Ctr+jでBUFFERをcat
bindkey -v '^s^k' ls-current                         # Ctr+s,Ctr+kでls
bindkey -v '^s^l' edit-command-line                  # Ctr+s,Ctr+lでコマンドラインエディタ編集
bindkey -v '^@' clear-screen                         # Ctr+@でclear-screen
bindkey -v '^_' cdup                                 # Ctr+_でcdup
bindkey -v '^s^@' kill-line                          # Ctr+s,Ctr+@でカーソル業以降削除
bindkey -v '^[[Z' reverse-menu-complete              # Shift+tabで逆タブ補完
# 補完メニュー選択モードキーマップ
bindkey -M menuselect '^b' backward-char                       # Ctr+bで左へ
bindkey -M menuselect '^f' forward-char                        # Ctr+fで右へ
bindkey -M menuselect '^g' .send-break                         # Ctr+gでsend-break2回
bindkey -M menuselect '^i' expand-or-complete                  # Ctr+iで補完候補選択
bindkey -M menuselect '^j' .accept-line                        # Ctr+jでaccept-line2回
bindkey -M menuselect '^k' .accept-and-infer-next-history      # Ctr+kで次の補完メニュー
bindkey -M menuselect '^h' backward-delete-char                # Ctr+hでbackward-delete-char(interactiveでbackword)
bindkey -M menuselect '^m' accept-line                         # Ctr+mでaccept-line
bindkey -M menuselect '^n' down-line-or-history                # Ctr+nで下へ
bindkey -M menuselect '^p' up-line-or-history                  # Ctr+pで上へ
bindkey -M menuselect '^r' history-incremental-search-forward  # Ctr+rでインクリメンタルサーチフォワード
bindkey -M menuselect '^u' send-break                          # Ctr+uでsend-break
bindkey -M menuselect '^]' accept-and-hold                     # Ctr+]で候補をバッファに入れる

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

## functions
# precmd
precmd() {
  vcs_info
  PROMPT_VIM_MODE_COLOR='blue'
}
# chpwd
chpwd() {
  [[ $dirstack[1]:h != $PWD ]] && ls
}

## widgets
# PROMPT_VIM_MODE_COLOR選択widgets
_zle-keymap-select() {
  case $KEYMAP in
    vicmd)
      PROMPT_VIM_MODE_COLOR="cyan" ;;
    main|viins)
      PROMPT_VIM_MODE_COLOR="blue" ;;
  esac

  zle reset-prompt
}
_ls-current() {
  zle -I
  ls
}
zle -N zle-keymap-select _zle-keymap-select               # _zle-keymap-selectをzle-keymap-selectに設定
zle -N edit-command-line                                  # コマンドラインを$EDITORで編集
zle -N ls-current _ls-current                             # ls用ウィジェット
zle -C interactive-complete-files menu-complete _generic  # ファイルインタラクティブ補完用ウィジェット

## zstyle
# vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
# completion
zstyle ':completion:*' completer _complete _match _ignored _prefix         # コンプリータ指定(通常,パターンマッチ,除外パターン復活,単語途中の補完)
zstyle ':completion:*' menu true select                                    # 補完候補のカーソル選択有効
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}                      # 補完候補色付け
zstyle ':completion:interactive-complete-files:*' completer _files         # ファイル補完用ウィジットコンプリータ指定
zstyle ':completion:interactive-complete-files:*' menu select interactive  # interactive-mode

## prompt
# プロンプト表示
PROMPT='%{[38;5;33m%}_%{[0m%}
%{[38;5;33m%}|%{[0m%}[${vcs_info_msg_0_}]:%~/
%{[38;5;33m%}└-%{[0m%}(%?)%F{$PROMPT_VIM_MODE_COLOR}%#%f '
RPROMPT='[%D{%T}|%n]'

## command-line
# 色定義
zle_highlight=(region:standout special:standout suffix:bold isearch:fg=red)
