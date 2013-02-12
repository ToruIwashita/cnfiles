#-----------------#
# Global Settings #
#-----------------#

### プロンプトの定義
PROMPT="%{$fg_bold[magenta]%}$%{$reset_color%} "

### キーバインド
# vimモード
bindkey -v
# Ctr+Aで行頭へ
bindkey "^A" beginning-of-line
# Ctr+Bで１文字左へ
bindkey "^B" backward-char
# Ctr+Dで１文字削除
bindkey "^D" delete-char-or-list
# Ctr+Eで行末へ
bindkey "^E" end-of-line
# Ctr+Fで１文字右へ
bindkey "^F" forward-char
# Ctr+Nで１行下へ
bindkey "^N" down-line-or-history
# Ctr+Pで１行上へ
bindkey "^P" up-line-or-history
# Ctr+Rでインクリメンタルサーチ
bindkey "^R" history-incremental-search-backward
# Shift+tabで逆タブ補完
bindkey "^[[Z" reverse-menu-complete
# Ctr+z無効化
bindkey -r "^Z"

### オートロード
# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit

### エイリアス
alias sz="source ~/.zshrc"

### オプション設定
# ビープ音なし
setopt NO_beep
# 補完のときプロンプトの位置を変えない
setopt always_last_prompt
# 重複コマンド記録しない
setopt hist_ignore_dups
# コマンド履歴・共有
setopt share_history
# コマンド履歴・シェル横断実行時間順ヒストリ保存
setopt incappendhistory
# コマンド履歴・コマンド実行時間保存
setopt extended_history

### コマンド履歴
# ヒストリファイル
HISTFILE=~/.zsh_history
# メモリに展開する履歴数
HISTSIZE=100000
# 保存する履歴数
SAVEHIST=100000

### vimモード識別
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
      PROMPT="%{$bg_bold[magenta]%}$%{$reset_color%} "
    ;;
    main|viins)
      PROMPT="%{$fg_bold[magenta]%}$%{$reset_color%} "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

### triwst/下のzsh,tmux,vimをコピー
function z_sync_origin() {
  cp -p ~/triwst/zshrc ~/.zshrc
  cp -p ~/triwst/tmux.conf ~/.tmux.conf
  cp -p ~/triwst/vimrc ~/.vimrc
  cp -rp ~/triwst/vim ~/.vim
  source ~/.zshrc
  cat ~/.zshrc
}

### triwst/下のzshrcをコピー
function z_sync_zshrc() {
  cp -p ~/triwst/zshrc ~/.zshrc
  source ~/.zshrc
  cat ~/.zshrc
}

### 各環境下の独自設定を連結する
function z_join_local() {
  cat ~/.zshrc_local >> ~/.zshrc
  source ~/.zshrc
  cat ~/.zshrc
}

#----------------#
# Local Settings #
#----------------#

