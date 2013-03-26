#! /bin/zsh

[ -f ~/.zsh.d/zconf ] || touch ~/.zsh.d/zconf
[ -f ~/.zsh.d/zconf_local ] || touch ~/.zsh.d/zconf_local
[ -f ~/.zsh.d/ls_colors ] || touch ~/.zsh.d/ls_colors
[ -d ~/.zsh.d/zfunc ] || mkdir ~/.zsh.d/zfunc
[ -d ~/.zsh.d/zfunc_local ] || mkdir ~/.zsh.d/zfunc_local
[ -d ~/.vim ] || mkdir ~/.vim
[ -d ~/.vim/plugin ] || mkdir ~/.vim/plugin

\cp -p ./zshrc ~/.zshrc
\cp -p ./tmux.conf ~/.tmux.conf
\cp -p ./vimrc ~/.vimrc
\cp -p ./zsh.d/zconf ~/.zsh.d/zconf
\cp -p ./zsh.d/ls_colors ~/.zsh.d/ls_colors

source_directories=(zsh.d/zfunc vim/plugin)
for dir in ${source_directories[@]}; do
  for file in `ls ./${dir}`; do
    \cp -p ./${dir}/${file} ~/.${dir}/${file}
  done
done

source ~/.zshrc

print "sync complete."
