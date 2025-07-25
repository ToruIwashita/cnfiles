## git
__git-branches() {
  local -a branches
  branches=(${(f)"$(__git-branch-list)"})
  compadd -a branches
}

__git-remote-branches() {
  local -a remote_branches
  remote_branches=(${(f)"$(__git-remote-branch-list)"})
  compadd -a remote_branches
}

__git-changed-files() {
  local -a changed_files
  changed_files=(${(f)"$(__git-changed-list)"})
  compadd -f -a changed_files
}

__git-deleted-files() {
  local -a deleted_files
  deleted_files=(${(f)"$(__git-deleted-list)"})
  compadd -f -a deleted_files
}

__git-untracked-files() {
  local -a untracked_files
  untracked_files=(${(f)"$(__git-untracked-list)"})
  compadd -f -a untracked_files
}

__git-staged-files() {
  local -a staged_files
  staged_files=(${(f)"$(__git-staged-list)"})
  compadd -f -a staged_files
}

__git-commits() {
  local -a commits commit_hashes commit_descriptions
  commits=(${(f)"$(__git-commit-list)"})

  for commit in $commits; do
    commit_hashes+=(${commit%% *})
    commit_descriptions+=($commit)
  done

  compadd -l -V commits -d commit_descriptions -a commit_hashes
}

__git-both-modified-files() {
  local -a both_modified_files
  both_modified_files=(${(f)"$(__git-both-modified-list)"})
  compadd -f -a both_modified_files
}

__git-unstaged-files() {
  local -a all_files
  all_files=(${(f)"$(__git-unstaged-list)"})
  compadd -f -a all_files
}

__git-diff-files() {
  local -a modified_files both_modified_files
  modified_files=(${(f)"$(__git-modified-list)"})
  both_modified_files=(${(f)"$(__git-both-modified-list)"})
  compadd -f -a modified_files
  compadd -f -a both_modified_files
}

_gam() {
  _arguments '*: :__git-diff-files'
}

_gau() {
  _arguments '*: :__git-untracked-files'
}

_gac() {
  _arguments '*: :__git-changed-files'
}

_gab() {
  _arguments '*: :__git-both-modified-files'
}

_gad() {
  _arguments '*: :__git-deleted-files'
}

_gc() {
  _arguments \
    '(-e --empty)'{-e,--empty}'[Empty commit]' \
    '(-f --fixup)'{-f,--fixup}'[Fixup commit]' \
    '(-t --temporary)'{-t,--temporary}'[Temporary commit]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

_gd() {
  _arguments \
    '(-l --log)'{-l,--log}'[Show commit diff]: :__git-commits' \
    '(-i --id-only)'{-i,--id-only}'[Show commit ID only]' \
    '(-n --name-only)'{-n,--name-only}'[Show only file names]' \
    '(-s --staged)'{-s,--staged}'[Show staged changes]: :__git-staged-files' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :__git-diff-files'
}

_gsw() {
  _arguments \
    '(-r --remote-branch)'{-r,--remote-branch}'[Switch remote branch]: :__git-remote-branches' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :__git-branches'
}

_gud() {
  _arguments '*: :__git-diff-files'
}

_gll() {
  _arguments \
    '(-b --rebase)'{-b,--rebase}'[Pull rebase]: :__git-branches' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

_gsh() {
  _arguments \
    '(-f --force)'{-f,--force}'[Force push]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

_gpickfile() {
  _arguments \
    '(-b -branch)'{-b,--branch}'[Checkout target branch]: :__git-branches' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :_files'
}

_gdeleteb() {
  _arguments \
    '(-a --all)'{-a,--all}'[Delete all merged branches]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

_gl() {
  _arguments \
    '(-g --graph)'{-g,--graph}'[Show graph display]' \
    '(-h --help)'{-h,--help}'[Show help text]'
}

_ga() {
  _arguments \
    '(-u --unstage)'{-u,--unstage}'[Unstage files]: :__git-staged-files' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '*: :__git-unstaged-files'
}

compdef _ga ga
compdef _gam gam
compdef _gau gau
compdef _gac gac
compdef _gab gab
compdef _gad gad
compdef _gc gc
compdef _gd gd
compdef _gsw gsw
compdef _gud gud
compdef _gll gll
compdef _gsh gsh
compdef _gpickfile gpickfile
compdef _gdeleteb gdeleteb
compdef _gl gl
