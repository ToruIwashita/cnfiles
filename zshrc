#-----------------#
# Global Settings #
#-----------------#

### コマンド履歴
HISTFILE=~/.zsh_history  # ヒストリファイル
HISTSIZE=600000          # メモリに展開する履歴数
SAVEHIST=600000          # 保存する履歴数
setopt hist_ignore_dups  # 重複コマンド記録しない
setopt share_history     # コマンド履歴共有

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

