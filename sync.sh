#! /bin/sh

[ -d ~/.zsh.d ]                    || mkdir ~/.zsh.d
[ -f ~/.zsh.d/zconf ]              || touch ~/.zsh.d/zconf
[ -f ~/.zsh.d/zconf_local ]        || touch ~/.zsh.d/zconf_local
[ -f ~/.zsh.d/ls_colors ]          || touch ~/.zsh.d/ls_colors
[ -d ~/.zsh.d/zfunc ]              || mkdir ~/.zsh.d/zfunc
[ -d ~/.zsh.d/_zfunc ]             || mkdir ~/.zsh.d/_zfunc
[ -d ~/.zsh.d/zfunc_local ]        || mkdir ~/.zsh.d/zfunc_local
[ -d ~/.zsh.d/_zfunc_local ]       || mkdir ~/.zsh.d/_zfunc_local
[ -d ~/.vim ]                      || mkdir ~/.vim
[ -f ~/.vim/vconf ]                || touch ~/.vim/vconf
[ -f ~/.vim/plugin_conf ]          || touch ~/.vim/plugin_conf
[ -f ~/.vim/autocommand ]          || touch ~/.vim/autocommand
[ -d ~/.vim/vfunc ]                || mkdir ~/.vim/vfunc
[ -d ~/.vim/abbreviate ]           || mkdir ~/.vim/abbreviate
[ -d ~/.vim/macro ]                || mkdir ~/.vim/macro
[ -d ~/.vim/bundle ]               || mkdir ~/.vim/bundle
[ -d ~/.vim/bundle/neobundle.vim ] || git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

\cp -p ./zshrc           ~/.zshrc
\cp -p ./tmux.conf       ~/.tmux.conf
\cp -p ./vimrc           ~/.vimrc
\cp -p ./vim/vconf       ~/.vim/vconf
\cp -p ./vim/plugin_conf ~/.vim/plugin_conf
\cp -p ./vim/autocommand ~/.vim/autocommand
\cp -p ./zsh.d/zconf     ~/.zsh.d/zconf
\cp -p ./zsh.d/ls_colors ~/.zsh.d/ls_colors

source_directories=(zsh.d/zfunc zsh.d/_zfunc vim/vfunc vim/abbreviate vim/macro)
for dir in ${source_directories[@]}; do
  for file in `ls ./${dir}`; do
    \cp -p ./${dir}/${file} ~/.${dir}/${file}
  done
done

echo "sync complete."
exec zsh
