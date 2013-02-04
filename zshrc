#-----------------#
# Global Settings #
#-----------------#

### bindkeys ###

bindkey "^[[Z" reverse-menu-complete

### functions ###

function z_sync_origin() {
  cp -p ~/triwst/zshrc ~/.zshrc
  source ~/.zshrc
  cat ~/.zshrc
}

function z_join_local() {
  cat ~/zshrc_local >> ~/.zshrc
  source ~/.zshrc
  cat ~/.zshrc
}

#----------------#
# Local Settings #
#----------------#

