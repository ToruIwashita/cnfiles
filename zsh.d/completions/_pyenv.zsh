## pyenv
__pyenv-python-versions() {
  compadd ${(R)${(R)${(@f)"$(pyenv versions)"}#?*[[:space:]]}%% *}
}

_pysw() {
  _arguments '*: :__pyenv-python-versions'
}

compdef _pysw pysw
