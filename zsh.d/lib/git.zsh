## git
__git-ref-head() {
  local ref
  ref=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return 1
  print $ref
}

__git-status() {
  __git-inside-work-tree || return
  print "$(git status --short --porcelain)"
}

__git-default-branch() {
  __git-inside-work-tree || return
  git symbolic-ref --short refs/remotes/origin/HEAD | cut -d'/' -f2
}

__git-branch-list() {
  __git-inside-work-tree || return
  local -a branches
  branches=(${${${(f)"$(git branch)"}:#\* \(HEAD*}#??})
  printf '%s\n' "${branches[@]}"
}

__git-remote-branch-list() {
  __git-inside-work-tree || return
  local -a existing_branches remote_branches
  existing_branches=(${(f)"$(__git-branch-list)"})
  remote_branches=(${${${${(f)"$(git branch --remote)"}:#*->*}#[[:space:]]*origin/}:|existing_branches})
  printf '%s\n' "${remote_branches[@]}"
}

__git-worktree-list() {
  __git-inside-work-tree || return
  local -a worktree_branches
  worktree_branches=(${${(M)${(f)"$(git branch)"}:#\+[[:space:]]*}#\+[[:space:]]})
  printf '%s\n' "${worktree_branches[@]}"
}

__git-changed-list() {
  __git-inside-work-tree || return
  git diff --name-only origin/HEAD...HEAD
}

__git-new-file-list() {
  __git-inside-work-tree || return
  local -a new_files
  new_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#?A*}#??}# })
  printf '%s\n' "${new_files[@]}"
}

__git-modified-list() {
  __git-inside-work-tree || return
  local -a modified_files
  modified_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#?M*}#??}# })
  printf '%s\n' "${modified_files[@]}"
}

__git-untracked-list() {
  __git-inside-work-tree || return
  local -a untracked_files
  untracked_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#\?\?*}#??}# })
  printf '%s\n' "${untracked_files[@]}"
}

__git-unstaged-list() {
  __git-inside-work-tree || return
  local -a all_files
  all_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#(?[MAD\?]|[UAD][UAD])*}#??}# })
  printf '%s\n' "${all_files[@]}"
}

__git-staged-list() {
  __git-inside-work-tree || return
  local -a staged_files
  staged_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#([MAD][^UAD]|[MAD] )*}#??}# })
  printf '%s\n' "${staged_files[@]}"
}

__git-both-modified-list() {
  __git-inside-work-tree || return
  local -a both_modified_files
  both_modified_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#UU*}#??}# })
  printf '%s\n' "${both_modified_files[@]}"
}

__git-deleted-list() {
  __git-inside-work-tree || return
  local -a deleted_files
  deleted_files=(${${${(M)${(0)"$(git status --porcelain -z 2>/dev/null)"}:#?D*}#??}# })
  printf '%s\n' "${deleted_files[@]}"
}

__git-commit-list() {
  __git-inside-work-tree || return
  git log --pretty=format:'%h - [%ad] @%an %s%d' --date=format:'%Y-%m-%d %H:%M' --decorate=short -n 30
}

__git-inside-work-tree() {
  [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]]
}

__git-commit-message-from-staged() {
  __git-inside-work-tree || return

  local status_line status_char file_path action
  local -a messages

  while IFS= read -r status_line; do
    [[ -z $status_line ]] && continue

    status_char=${status_line[1]}
    file_path=${status_line[4,-1]}

    case $status_char in
      M) action="Update" ;;
      A) action="Create" ;;
      D) action="Delete" ;;
      R)
        action="Rename"
        file_path=${file_path/ -> / to }
        ;;
      *) continue ;;
    esac

    messages+=("$action $file_path")
  done < <(git status --short --porcelain)

  if (( ${#messages} == 0 )); then
    return 1
  fi

  printf '%s\n' "${messages[@]}"
}

__ga() {
  integer commit
  local self_cmd help usage commit_message
  local -a file_paths

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <files>
              [-c --commit]
              [-h --help]
EOF`

  if ! __git-inside-work-tree; then
    print 'Not a git repository: .git'
    print $usage 1>&2
    return 1
  fi

  while (( $# > 0 )); do
    case "$1" in
      -c | --commit)
        (( commit++ ))
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift
        file_paths+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        file_paths+=("$1")
        shift 1
        ;;
    esac
  done

  if (( ! ${#file_paths} )); then
    print $usage 1>&2
    return 1
  fi

  git add $(git rev-parse --show-toplevel)/"${^file_paths[@]}"

  if (( commit )); then
    commit_message=$(__git-commit-message-from-staged)

    if (( $#commit_message )); then
      git commit -m "$commit_message"
    fi
  fi
}
