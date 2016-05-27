## prefix
# Ctr+qをprefixに設定
set -g prefix C-q

## option
# TERM設定
set -g default-terminal 'screen-256color'
# screen-256colorでヤンク時にクリップボード共有する
set -ag terminal-overrides "screen:Ms=\\E]52;%p1%s;%p2%s\\7"
# vim風copy-mode
setw -g mode-key vi
# キーストロークのディレイ0sec
set -s escape-time 0
# プレフィックスキーのリピート時間(デフォルト500ms)
set -g repeat-time 500
# desplay-panesの表示時間5000ms
set -g display-panes-time 5000
# ステータスリフレッシュ間隔(デフォルト15)
set -g status-interval 2
# ウィンドウの番号を0からではなく1からにする
set -g base-index 1
# buffer
set -g buffer-limit 33
set -g history-limit 5000
# ウィンドウで動作があるとハイライト
setw -g monitor-activity on
set -g visual-activity off
# window-status-current
setw -g window-status-current-fg white
setw -g window-status-current-bg colour234
setw -g window-status-current-attr bold
# pane
set -g pane-border-fg colour188
set -g pane-border-bg colour16
set -g pane-active-border-fg colour188
set -g pane-active-border-bg colour20
# status-line
set -g status-fg colour188
set -g status-bg colour234
set -g status-left-length 32
set -g status-right-length 150
set -g status-left "#[fg=colour223,bg=colour166,nobold] #(whoami) "
set -g window-status-format "#[fg=colour188,bg=colour234] #I #W "
set -g window-status-current-format "#[fg=colour38,bg=colour20,noreverse,nobold] #I #W "
set -g status-right "#[fg=colour38,bg=colour234,nobold]#(tmux-mem-cpu-load) #[fg=colour223,bg=colour166,nobold] [%Y-%m-%d(%a) %H:%M] "

## unbind
# デフォルトprefixを解除
unbind C-b
unbind c
unbind n
unbind o
unbind p
unbind z
unbind ,
unbind .
unbind [
unbind ]
unbind C-j
unbind C-n
unbind C-p
unbind C-z
unbind C-[
unbind C-]

## bind
# detach
bind C-d detach
# reload config
bind r source-file ~/.tmux.conf
# 新しいウィンドウを作る
bind t new-window
bind C-t new-window
# ウィンドウのリネーム
bind . command-prompt -I '#W' "rename-window '%%'"
# ペイン選択
bind - display-panes
# ウィンドウkill
bind X kill-window
# ウィンドウ上下分割
bind s split-window -v
# ウィンドウ左右分割
bind v split-window -h
# ウィンドウindex変更
bind m command-prompt "move-window -t %%"
# ウィンドウ選択select
bind w command-prompt "select-window -t %%"
# ウィンドウ選択choose
bind W choose-window
# 次のウィンドウへ
bind -r ] next-window
bind -r C-] next-window
# 前のウィンドウへ
bind -r [ previous-window
bind -r C-[ previous-window
# 直前のウィンドウへ
bind -r _ last-window
bind -r C-_ last-window
# ペイン移動
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind C-h select-pane -L
bind C-j select-pane -D
bind C-k select-pane -U
bind C-l select-pane -R
# ペインリサイズ
bind -r H resize-pane -L 2
bind -r J resize-pane -D 1
bind -r K resize-pane -U 1
bind -r L resize-pane -R 2
# ペインkill
bind x kill-pane
# コピーモード
bind y copy-mode
bind C-y copy-mode
# コピー開始
bind -t vi-copy v begin-selection
# ヤンク
bind -t vi-copy y copy-selection
# 1行ヤンク
bind -t vi-copy Y copy-line
# C-vで矩形範囲選択
bind -t vi-copy C-v rectangle-toggle
# 最新バッファペースト
bind p paste-buffer
# バッファ選択ペースト
bind P choose-buffer
# ウィンドウデフォルト表示s-v
bind S split-window -v \; split-window -h
# ウィンドウデフォルト表示v-s
bind V split-window -h \; split-window -v
# ウィンドウデフォルト表示Multi
bind M split-window -h \; split-window -v \; select-pane -t :.+ \; split-window -v \; select-pane -t :.-
# ウィンドウデフォルト表示Triple
bind T split-window -v \; split-window -v \; select-layout even-horizontal
