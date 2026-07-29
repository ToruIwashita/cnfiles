## peco-cd-prod
_peco-cd-prod() {
  local selected_dir

  selected_dir=$(find "$PRODS_DIR_PATH" -mindepth 1 -maxdepth 1 -type d -print | sort | peco --select-1 2>/dev/null)

  if (( ! $#selected_dir )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $selected_dir"
  zle accept-line
}
zle -N peco-cd-prod _peco-cd-prod
