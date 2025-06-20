## git
__git-branches() {
  local -a branches
  branches=(${(f)"$(__git-branch-list)"})
  compadd -Q -a branches
}

__git-remote-branches() {
  local -a remote_branches
  remote_branches=(${(f)"$(__git-remote-branch-list)"})
  compadd -Q -a remote_branches
}

__git-changed-files() {
  compadd $(__git-changed-list)
}

__git-modified-files() {
  compadd $(__git-modified-list)
}

__git-deleted-files() {
  compadd $(__git-deleted-list)
}

__git-untracked-files() {
  compadd $(__git-untracked-list)
}

__git-staged-files() {
  compadd $(__git-staged-list)
}

__git-both-modified-files() {
  compadd $(__git-both-modified-list)
}

_gam() {
  _arguments '*: :__git-modified-files'
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
  _arguments '*: :__git-modified-files'
}

_gsw() {
  _arguments \
    '(-r --remote-branch)'{-r,--remote-branch}'[Switch remote branch]: :__git-remote-branches' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :__git-branches'
}

_gud() {
  _arguments '*: :__git-modified-files'
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
