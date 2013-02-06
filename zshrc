#-----------------#
# Global Settings #
#-----------------#

### vimモード
bindkey -v
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

### キーバインド
bindkey "^A" beginning-of-line                    # Ctr+Aで行頭へ
bindkey "^B" backward-char                        # Ctr+Bで１文字左へ
bindkey "^E" end-of-line                          # Ctr+Eで行末へ
bindkey "^F" forward-char                         # Ctr+Fで１文字右へ
bindkey "^N" down-line-or-history                 # Ctr+Nで１行下へ
bindkey "^P" up-line-or-history                   # Ctr+Pで１行上へ
bindkey "^R" history-incremental-search-backward  # Ctr+Rでインクリメンタルサーチ

### エイリアス
alias sz="source ~/.zshrc"

### 色の定義
autoload -Uz colors && colors

### プロンプトの定義
PROMPT="%{$fg_bold[magenta]%}$%{$reset_color%} "

### ビープ音なし
setopt NO_beep

### 自動補完
autoload -Uz compinit && compinit

### 補完のときプロンプトの位置を変えない
setopt always_last_prompt

### コマンド履歴
HISTFILE=~/.zsh_history  # ヒストリファイル
HISTSIZE=100000          # メモリに展開する履歴数
SAVEHIST=100000          # 保存する履歴数
setopt hist_ignore_dups  # 重複コマンド記録しない
setopt share_history     # コマンド履歴共有
setopt incappendhistory  # シェル横断実行時間順ヒストリ保存
setopt extended_history  # コマンド実行時間保存

### Shift+tabで逆タブ補完
bindkey "^[[Z" reverse-menu-complete

### githubのzshrcをコピーして読み込む
function z_sync_origin() {
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

