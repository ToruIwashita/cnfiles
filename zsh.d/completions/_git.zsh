## git関数用補完
__git-branches() {
  compadd $(__git-branch-list)
}

__git-remote-branches() {
  compadd $(__git-remote-branch-list)
}

__git-changed-files() {
  compadd $(__git-changed-list)
}

__git-modified-files() {
  compadd $(__git-modified-list)
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

_grh() {
  _arguments \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :__git-staged-files'
}

_gc() {
  _arguments \
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
compdef _grh grh
compdef _gc gc
compdef _gd gd
compdef _gsw gsw
compdef _gud gud
compdef _gll gll
compdef _gsh gsh
compdef _gpickfile gpickfile
compdef _gdeleteb gdeleteb
