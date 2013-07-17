#! /bin/zsh

[ -f ~/.zsh.d/zconf ] || touch ~/.zsh.d/zconf
[ -f ~/.zsh.d/zconf_local ] || touch ~/.zsh.d/zconf_local
[ -f ~/.zsh.d/ls_colors ] || touch ~/.zsh.d/ls_colors
[ -d ~/.zsh.d/zfunc ] || mkdir ~/.zsh.d/zfunc
[ -d ~/.zsh.d/_zfunc ] || mkdir ~/.zsh.d/_zfunc
[ -d ~/.zsh.d/zfunc_local ] || mkdir ~/.zsh.d/zfunc_local
[ -d ~/.zsh.d/_zfunc_local ] || mkdir ~/.zsh.d/_zfunc_local
[ -d ~/.vim ] || mkdir ~/.vim
[ -f ~/.vim/vconf ] || touch ~/.vim/vconf
[ -d ~/.vim/abbreviate ] || mkdir ~/.vim/abbreviate
[ -d ~/.vim/abbreviate_local ] || mkdir ~/.vim/abbreviate_local
[ -d ~/.vim/macro ] || mkdir ~/.vim/macro
[ -d ~/.vim/macro_local ] || mkdir ~/.vim/macro_local
[ -d ~/.vim/bundle ] || mkdir ~/.vim/bundle

\cp -p ./zshrc ~/.zshrc
\cp -p ./tmux.conf ~/.tmux.conf
\cp -p ./vimrc ~/.vimrc
\cp -p ./vim/vconf ~/.vim/vconf
\cp -p ./zsh.d/zconf ~/.zsh.d/zconf
\cp -p ./zsh.d/ls_colors ~/.zsh.d/ls_colors

source_directories=(zsh.d/zfunc zsh.d/_zfunc vim/plugin vim/abbreviate vim/macro)
for dir in ${source_directories[@]}; do
  for file in `ls ./${dir}`; do
    \cp -p ./${dir}/${file} ~/.${dir}/${file}
  done
done

print "sync complete."
exec zsh
