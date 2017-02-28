## rbenv関連補完
__rbenv-ruby-versions() {
  compadd ${(R)${(R)${(@f)"$(rbenv versions)"}#?*[[:space:]]}%% *}
}

_rsw() {
  _arguments '*: :__rbenv-ruby-versions'
}

compdef _rsw rsw
