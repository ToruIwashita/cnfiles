## 定数の設定
ZSH_DIR=.zsh.d
FUNCTION_DIRS=(
  ~/$ZSH_DIR/functions
  ~/$ZSH_DIR/completions
  ~/$ZSH_DIR/local/functions
  ~/$ZSH_DIR/local/completions
)

## 環境変数設定
# utf-8
export LANG=ja_JP.UTF-8
# xterm-256color
export TERM=xterm-256color
# 区切り文字
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# LS色設定
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
# LD_LIBRARY_PATH,INCLUDE関連付け
[[ -z $ld_library_path ]] && typeset -xT LD_LIBRARY_PATH ld_library_path
[[ -z $include ]] && typeset -xT INCLUDE include

## 関数ロード
# 色の定義
autoload -Uz colors && colors
# 自動補完
autoload -Uz compinit && compinit
# 複数のファイルを扱うようなmv
autoload -Uz zmv
# VersionControlSystem
autoload -Uz vcs_info
# フック関数登録
autoload -Uz add-zsh-hook
# 補完メニュー選択モードのキーマップ
zmodload -i zsh/complist

## 各種設定・オリジナル関数読込
# 設定読込
source ~/$ZSH_DIR/config.zsh
source ~/$ZSH_DIR/config.local.zsh
# 関数読込
fpath=(${FUNCTION_DIRS} $fpath)
for dir in ${FUNCTION_DIRS[@]}; do
  for function in ${dir}/*.zsh(.); do
    autoload -Uz $function:t && $function:t
  done
done

# 重複パスを除去(パス設定が全て済んだ後に実施)
typeset -U path fpath ld_library_path include

## 補完
# コンプリータ指定(通常,パターンマッチ,除外パターン復活,単語途中の補完)
zstyle ':completion:*' completer _complete _match _ignored _prefix
# 補完候補のカーソル選択有効
zstyle ':completion:*' menu true select
# 補完候補色付け
if [[ -n $LS_COLORS ]]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

## プロンプトの定義
# 色定義
local default_style color_style
default_style='[0m'
color_style='[38;5;27m'
# VIMモード色
VIMODE_COLOR="blue"
function _zle-keymap-select {
  case $KEYMAP in
    vicmd)
      VIMODE_COLOR="cyan" ;;
    main|viins)
      VIMODE_COLOR="blue" ;;
  esac

  zle reset-prompt
}
zle -N zle-keymap-select _zle-keymap-select
# vcsの情報表示
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }
# プロンプト表示
PROMPT='${color_style}_${default_style}
|[${vcs_info_msg_0_}]:%~/
└-(%?)%F{$VIMODE_COLOR}%#%f '
RPROMPT='[%D{%T}|%n]'

## cd後にls実行
function chpwd() {
  [[ $dirstack[1]:h != $PWD ]] && ls
}
