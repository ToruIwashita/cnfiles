## sbtenv関連補完
__sbtenv-sbt-versions() {
  compadd ${(R)${(R)${(@f)"$(sbtenv versions)"}#?*[[:space:]]}%% *}
}

_sbtsw() {
  _arguments '*: :__sbtenv-sbt-versions'
}

compdef _sbtsw sbtsw
