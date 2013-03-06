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

