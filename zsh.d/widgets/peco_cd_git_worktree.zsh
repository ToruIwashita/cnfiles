## peco-cd-git-worktree
_peco-cd-git-worktree() {
  local selected_dir

  selected_dir=$(find "$GIT_WORKTREES_DIR_PATH" -mindepth 2 -maxdepth 2 -type d -print | sort | peco --select-1 2>/dev/null)

  if (( ! $#selected_dir )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $selected_dir"
  zle accept-line
}
zle -N peco-cd-git-worktree _peco-cd-git-worktree
