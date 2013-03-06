## 設定読込
source ~/.zsh.d/zconf
source ~/.zsh.d/zconf_local

## オートロード
# 自作関数
function_directories=(.zsh.d/zfunc .zsh.d/zfunc_local)
for dir in ${function_directories[@]}; do
  fpath=($fpath ~/${dir})

  for file in `ls ~/${dir}`; do
    autoload -Uz ~/${dir}/${file}(:t) && ~/${dir}/${file}(:t)
  done
done

# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit

## triwst/下のzsh,tmux,vimをコピー
function z_sync_origin() {
  [ -d ~/.zsh.d ] || mkdir ~/.zsh.d
  [ -d ~/.zsh.d/zfunc ] || mkdir ~/.zsh.d/zfunc
  [ -d ~/.zsh.d/zfunc_local ] || mkdir ~/.zsh.d/zfunc_local
  [ -d ~/.vim ] || mkdir ~/.vim
  [ -d ~/.vim/plugin ] || mkdir ~/.vim/plugin

  cp -p ~/.triwst/zshrc ~/.zshrc
  cp -p ~/.triwst/tmux.conf ~/.tmux.conf
  cp -p ~/.triwst/vimrc ~/.vimrc
  cp -p ~/.triwst/zsh.d/* ~/.zsh.d/
  cp -p ~/.triwst/zsh.d/zfunc/* ~/.zsh.d/zfunc/
  cp -p ~/.triwst/zsh.d/zfunc_local/* ~/.zsh.d/zfunc_local/
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

