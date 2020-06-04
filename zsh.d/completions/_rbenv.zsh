## rbenv
__rbenv-ruby-versions() {
  compadd ${(R)${(R)${(@f)"$(rbenv versions)"}#?*[[:space:]]}%% *}
}

_rbsw() {
  _arguments '*: :__rbenv-ruby-versions'
}

compdef _rbsw rbsw
