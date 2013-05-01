# prefixの変更
unbind-key C-b
set-option -g prefix C-t
bind-key C-t send-prefix

# ウィンドウ・ペインの最初の番号を指定を1に。デフォルトだと0から
set -g base-index 1
set -g pane-base-index 1
# C-gをキャンセルコマンドとして利用する
unbind C-g
# 256色表示
set -g default-terminal "screen-256color"
# tmuxの設定を再読み込み
unbind r
bind C-r source-file ~/.tmux.conf ; display-message " tmux Reloaded!!"
# コピーモードでemacs風の操作(終了時はC-x c)
setw -g mode-key emacs
# 必要ない？
setw -g utf8 on
# ディスプレイ番号を表示 表示された番号を入力して移動
bind i display-panes
set display-panes-time 10000

set-window-option -g mode-mouse on
set -g terminal-overrides 'xterm*:smcup@:rmcup@'

# clock-mode入ってしまったら C-? qで戻ってくる
# clock-modeはunbindしちゃいましょ
unbind t
unbind h 

set repeat-time 1000
bind C-q confirm-before "kill-window"
bind q   confirm-before "kill-pane"
bind c new-window
bind C-p previous-window
bind C-n next-window
bind t confirm-before "last-window"
bind o rotate-window

bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R
bind -r Left  resize-pane -L 5
bind -r Down  resize-pane -D 5
bind -r Up    resize-pane -U 5
bind -r Right resize-pane -R 5 

bind C-s split-window -v
bind C-v split-window -h
bind C-w choose-window

bind d confirm-before "detach-client"
bind C-[ copy-mode
bind C-] paste-buffer
