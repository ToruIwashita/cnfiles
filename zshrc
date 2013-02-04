#-----------------#
# Global Settings #
#-----------------#

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

autoload -U compinit
compinit
setopt auto_pushd
setopt correct
setopt cdable_vars

### functions ###

function z_sync_origin() {
  cp -p ~/triwst/zshrc ~/.zshrc
  source ~/.zshrc
}

function z_join_local() {
  cat ~/zshrc_local >> ~/.zshrc
  source ~/.zshrc
}


#----------------#
# Local Settings #
#----------------#

