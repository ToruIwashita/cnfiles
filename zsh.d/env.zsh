## 環境変数設定
export LANG=ja_JP.UTF-8                   # utf-8
export TERM=screen-256color               # 端末の種類(tmuxのサポート対象に設定)
export HISTFILE=~/.zsh_history            # 履歴ファイル
export HISTSIZE=100000                    # メモリに展開する履歴数
export SAVEHIST=100000                    # 保存する履歴数
export EDITOR=vim                         # デフォルトで使用されるエディタ
export AI_AGENT=claude                    # デフォルトで使用されるAIエージェント
export AI_SEARCH_AGENT=gemini             # デフォルトで使用される検索AIエージェント
export WORDCHARS='*?_-[]~=&;!#$%^(){}<>'  # 区切り文字
export PROMPT_VIM_MODE_COLOR='blue'       # PROMPTのVIMモード色
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
export CNFILES_DIR_PATH=~/.cnfiles
export LOCAL_DIR_PATH=~/local
export WORKS_DIR_PATH=~/works
export CONFIG_DIR_PATH=~/.config
export LOG_DIR_PATH=~/log
export LINT_DIR_PATH=~/.lint
export CACHE_DIR_PATH=~/.cache
export ZSH_DIR_PATH=$zsh_dir_path
export ADOTDIR=$zsh_dir_path/antigen
export VIM_DIR_PATH=~/.vim
export TMUX_DIR_PATH=~/.tmux
export MARKDOWN_TEXTS_DIR_PATH=~/markdown_texts
export MARKDOWN_TEXTS_MODELING_SESSION_FILE_PATH=$MARKDOWN_TEXTS_DIR_PATH/.modeling.session.vim
export TMP_DIR_PATH=$WORKS_DIR_PATH/tmp
export MEMOLIST_DIR_PATH=$WORKS_DIR_PATH/memolist
export MEMOLIST_TASK_MARKDOWN_FILE_PATH=$MEMOLIST_DIR_PATH/00-task.md
export MEMOLIST_TMP_DOT_FILE_PATH=$MEMOLIST_DIR_PATH/00-tmp.dot
export MEMOLIST_TMP_MARKDOWN_FILE_PATH=$MEMOLIST_DIR_PATH/00-tmp.md
export MEMOLIST_TMP_SQL_FILE_PATH=$MEMOLIST_DIR_PATH/00-tmp.sql
export MEMOLIST_TMP_TEXT_FILE_PATH=$MEMOLIST_DIR_PATH/00-tmp.txt
export MEMOLIST_TMP_UML_FILE_PATH=$MEMOLIST_DIR_PATH/00-tmp.uml
export MEMOLIST_TMP_JSON_FILE_PATH=$MEMOLIST_DIR_PATH/00-tmp.json

## agentic coding
export AGENTIC_CODING_DIR_PATH=$MARKDOWN_TEXTS_DIR_PATH/agentic_coding
export AGENTIC_CODING_DEVELOPMENT_GUIDE_DIR_PATH=$AGENTIC_CODING_DIR_PATH/development_guide
export AGENTIC_CODING_CODE_IMPLEMENTATION_GUIDE_DIR_PATH=$AGENTIC_CODING_DIR_PATH/code_implementation_guide
export AGENTIC_CODING_COMMANDS_DIR_PATH=$AGENTIC_CODING_DIR_PATH/commands
export AGENTIC_CODING_TASK_TEMPLATE_DIR_PATH=$AGENTIC_CODING_DIR_PATH/task_template
