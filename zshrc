## 設定読込
[ -f ~/.zsh.d/zconf ] || touch ~/.zsh.d/zconf
[ -f ~/.zsh.d/zconf_local ] || touch ~/.zsh.d/zconf_local
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

