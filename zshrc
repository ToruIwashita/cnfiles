## 変数の設定
# 局所変数
local zsh_dir zsh_plugin_dir zsh_completions_src dir file
local -a zsh_function_dirs
# グローバル変数
typeset -ga precmd_functions
typeset -ga chpwd_functions

zsh_dir=.zsh.d
zsh_plugin_dir=~/$zsh_dir/plugin
zsh_function_dirs=(
  ~/$zsh_dir/functions
  ~/$zsh_dir/completions
  ~/$zsh_dir/widgets
  ~/$zsh_dir/completion_widgets
  ~/$zsh_dir/local/functions
  ~/$zsh_dir/local/completions
  ~/$zsh_dir/local/widgets
)
# plugin path
zsh_completions_dir=$zsh_plugin_dir/zsh-completions/src
zsh_history_substring_search_src=$zsh_plugin_dir/zsh-history-substring-search/zsh-history-substring-search.zsh
zsh_golang_misc_src=$zsh_plugin_dir/golang-misc-zsh/src/go.zsh

## 環境変数設定
export LANG=ja_JP.UTF-8                    # utf-8
export TERM=xterm-256color                 # xterm-256color
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # 区切り文字
export PROMPT_VIM_MODE_COLOR='blue'        # PROMPTのVIMモード色
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

## LD_LIBRARY_PATH,INCLUDE関連付け
[[ -z $ld_library_path ]] && typeset -xT LD_LIBRARY_PATH ld_library_path
[[ -z $include ]] && typeset -xT INCLUDE include

## path関連設定
# fpath設定,ディレクトリ読み込みplugin追加
fpath=($zsh_function_dirs $zsh_completions_dir $fpath)

## 関数ロード
autoload -Uz colors && colors          # 色の定義
autoload -Uz compinit && compinit -u   # 自動補完
autoload -Uz zmv                       # 複数のファイルを扱うようなmv
autoload -Uz vcs_info                  # VersionControlSystem
autoload -Uz chpwd_recent_dirs         # 最近使用したdir保持
autoload -Uz chpwd_recent_filehandler  # 最近使用したdirを保持するfileの操作
autoload -Uz cdr                       # 最近使用したディレクトリを補完
autoload -Uz add-zsh-hook              # フック関数登録
autoload -Uz edit-command-line         # コマンドライン編集
zmodload -i zsh/complist               # 補完メニュー選択モードのキーマップ
zmodload -i zsh/terminfo               # terminfoの配列データを扱う(zsh-history-substring-search用にロード)

## plugin読み込み
source $zsh_history_substring_search_src
source $zsh_golang_misc_src

## 各種設定・オリジナル関数読込
# 関数読込
for dir in ${zsh_function_dirs[@]}; do
  for file in ${dir}/*.zsh(.); do
    autoload -Uz $file:t && $file:t
  done
done
# 設定読込
source ~/$zsh_dir/config.zsh
source ~/$zsh_dir/config.local.zsh

# 重複パスを除去
typeset -U path fpath precmd_functions chpwd_functions ld_library_path include
