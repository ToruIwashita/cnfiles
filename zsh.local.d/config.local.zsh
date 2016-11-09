# rbenv設定
if [[ -d ~/.rbenv  ]]; then
  eval "$(rbenv init - zsh 2>/dev/null)"
fi

## alias
# cd
alias cdz="cd $ZSH_DIR_PATH"
alias cdv="cd $VIM_DIR_PATH"
alias cdg='cd ~/.go'
alias cdl="cd $LOCAL_DIR_PATH"
alias cds='cd ~/src'
alias cdsg='cd ~/src/go'
alias cdw='cd ~/works'
alias cdc='cd ~/.cnfiles'
alias cdml='cd ~/.memolist'
# ctags
alias ct='ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,go,ruby'

## for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
## bindkey
#bindkey -v '^sc' pbcopy-current # Ctr+s,pでBUFFERをcatしてpbcopy
## alias
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
