## scalaenv
__scalaenv-scala-versions() {
  compadd ${(R)${(R)${(@f)"$(scalaenv versions)"}#?*[[:space:]]}%% *}
}

_scalasw() {
  _arguments '*: :__scalaenv-scala-versions'
}

compdef _scalasw scalasw
