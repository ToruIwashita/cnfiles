#-----------------#
# Global Settings #
#-----------------#

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

autoload -U compinit
compinit
setopt auto_pushd
setopt correct
setopt cdable_vars

function zshrc_merge() {
  cat ~/zshrc_local >> ~/.zshrc
}

function z_sync_origin() {
  cp -p ~/triwst/.zshrc ~/.zshrc
}

#----------------#
# Local Settings #
#----------------#

