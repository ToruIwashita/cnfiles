## prefix
# Ctr+qをprefixに設定
set -g prefix C-q

## option
# TERM設定
set -g default-terminal 'screen-256color'
# copy-mode vim
setw -g mode-key vi
# キーストロークのディレイ0sec
set -s escape-time 0
# プレフィックスキーのリピート時間(デフォルト500ms)
set -g repeat-time 500
# display-panesの表示時間5000ms
set -g display-panes-time 5000
# ステータスリフレッシュ間隔(デフォルト15)
set -g status-interval 2
# ウィンドウの番号を0からではなく1からにする
set -g base-index 1
# buffer
set -g buffer-limit 33
set -g history-limit 50000
# ウィンドウで動作があるとハイライト
setw -g monitor-activity on
# monitor-activity onでウィンドウ動作があった時にステータスラインメッセージを表示
set -g visual-activity off

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
unbind Space

## bind
# detach
bind C-d detach
# reload config
bind r source-file ~/.tmux.conf

## ウィンドウ操作
# 新しいウィンドウを作る
bind t new-window -c '#{pane_current_path}'
bind C-t new-window -c '#{pane_current_path}'
# ウィンドウのリネーム
bind . command-prompt -I '#W' 'rename-window "%%"'
# ウィンドウkill
bind X kill-window
# ウィンドウ上下分割
bind s split-window -v -c '#{pane_current_path}'
# ウィンドウ左右分割
bind i split-window -h -c '#{pane_current_path}'
# ウィンドウindex変更
bind m command-prompt 'move-window -t %%'
# ウィンドウ選択choose
bind ';' choose-window
# ウィンドウ選択select
bind w command-prompt 'select-window -t %%'
# 次のウィンドウへ
bind -r ] next-window
bind -r C-] next-window
# 前のウィンドウへ
bind -r [ previous-window
bind -r C-[ previous-window
# 直前のウィンドウへ
bind -r _ last-window
bind -r C-_ last-window

## ペイン操作
# ペイン選択
bind - display-panes
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
# ペインを次に入れ替え
bind -r < swap-pane -U
# ペインを前に入れ替え
bind -r > swap-pane -D
# 等間隔分割に変更する
bind | select-layout even-horizontal
bind - select-layout even-vertical
# ペインkill
bind x kill-pane
# 等間隔4分割(Multi)
bind M split-window -h \; split-window -v \; select-pane -t :.+ \; split-window -v \; select-pane -t :.-
# ペイン同時操作
bind Space setw synchronize-panes \; display "synchronize-panes #{?pane_synchronized,on,off}"

## コピーモード
bind v copy-mode
bind C-v copy-mode
## bind
# コピー開始
bind -T copy-mode-vi v send -X begin-selection
# コピーキャンセル
bind -T copy-mode-vi C-j send -X clear-selection
# ヤンク
bind -T copy-mode-vi y send -X copy-selection
# 逆f
bind -T copy-mode-vi C-f command-prompt -1p '(jump backward)' 'send -X jump-backward "%%%"'
# 逆再jump
bind -T copy-mode-vi C-_ send-keys -X jump-reverse
# 選択範囲open
bind -T copy-mode-vi '-' send -X copy-pipe-and-cancel 'xargs -0 open'
# 選択範囲の英語を日本語に翻訳
bind -T copy-mode-vi , send -X copy-pipe-and-cancel 'xargs -I {} gtran {} | xargs -I {} tmux-display-message {}'
# 選択範囲の日本語を英語に翻訳
bind -T copy-mode-vi i send -X copy-pipe-and-cancel 'xargs -I {} gtran -source "ja" -target "en" {} | xargs -I {} tmux-display-message {}'
# 選択範囲のGoogle検索
bind -T copy-mode-vi Space send -X copy-pipe-and-cancel "xargs -I {} open https://www.google.co.jp/search?q='{}'"

## ペースト
# 最新バッファペースト
bind p paste-buffer
# バッファ選択ペースト
bind P choose-buffer
