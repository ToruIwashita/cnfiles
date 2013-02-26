## fpathに.zfunc,.zfunc_local追加
fpath=($fpath ~/.zfunc)
#fpath=($fpath ~/.zfunc_local)

## オートロード
# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit
# 自作関数 [TODO]: ファイルが存在しないときはオートロードしないように分岐させる
#zfunc_files=$(ls ~/.zfunc/)
#for file in ${zfunc_files}; do
#  autoload -Uz ~/.zfunc/${file} && ~/.zfunc/${file}
#done

#local_zfunc_files=$(ls ~/.zfunc_local/)
#for file in ${local_zfunc_files}; do
#  autoload -Uz ~/.zfunc_local/${file} && ~/.zfunc_local/${file}
#done
autoload -Uz ~/.zfunc/*(:t) && ~/.zfunc/*(:t)
#autoload -Uz ~/.zfunc_local/*(:t) && ~/.zfunc_local/*(:t)


## プロンプトの定義
PROMPT="[%n]:%./%{$fg_bold[blue]%}%#%{$reset_color%} "
# vimモード識別
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
      PROMPT="[%n]:%./%{$bg_bold[blue]%}%#%{$reset_color%} "
    ;;
    main|viins)
      PROMPT="[%n]:%./%{$fg_bold[blue]%}%#%{$reset_color%} "
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

## キーバインド
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

## エイリアス
alias sz="source ~/.zshrc"

## オプション設定
# 自動CD
setopt auto_cd
# 自動的にディレクトリスタックにカレントディレクトリスタック追加
setopt auto_pushd
# ファイル補完種類表示
setopt list_types
# ビープ音なし
setopt no_beep
# 補完のときプロンプトの位置を変えない
setopt always_last_prompt
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
# ヒストリファイル
HISTFILE=~/.zsh_history
# メモリに展開する履歴数
HISTSIZE=100000
# 保存する履歴数
SAVEHIST=100000

## triwst/下のzsh,tmux,vimをコピー
function z_sync_origin() {
  [ -d ~/.zfunc ] || mkdir ~/.zfunc
  [ -d ~/.vim ] || mkdir ~/.vim
  [ -d ~/.vim/plugin ] || mkdir ~/.vim/plugin

  cp -p ~/.triwst/zshrc ~/.zshrc
  cp -p ~/.triwst/tmux.conf ~/.tmux.conf
  cp -p ~/.triwst/vimrc ~/.vimrc
  cp -p ~/.triwst/zfunc/* ~/.zfunc/
  cp -p ~/.triwst/vim/plugin/* ~/.vim/plugin/
  source ~/.zshrc

  echo "sync complete."
}

## .triwst/下のzshrcをコピー
function z_sync_zshrc() {
  cp -p ~/.triwst/zshrc ~/.zshrc
  source ~/.zshrc

  echo "sync complete."
}

