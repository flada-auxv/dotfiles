export LANG=ja_JP.UTF-8
export EDITOR=emacsclient
export SSL_CERT_FILE=/usr/local/etc/cacert.pem

# homebrewを優先
export PATH=~/bin:/usr/local/bin:$PATH:$HOME/bin

# rbenv
path=($HOME/.rbenv/bin(N) $path)
eval "$(rbenv init -)"

# emacsのエイリアス 
alias e='emacsclient -t'
alias kille="emacsclient -e '(kill-emacs)'"
if pgrep emacs >/dev/null 2>&1; then
    echo "Emacs server is already running..."
else
    `emacs --daemon`
fi

# 補完の設定
autoload -U compinit
compinit

setopt auto_cd  # ディレクトリ名のみでcdできる
setopt auto_pushd # "cd -" でtaBを押すと移動履歴のリストが表示される
setopt correct # コマンドのスペルチェック
setopt no_beep # ビープ音を鳴らない様にする

autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
# SSHログイン時のプロンプト
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
;

export LANG=ja_JP.UTF-8

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history 

# コマンド履歴検索のショートカットをC-nとC-pに
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

alias ls="ls -p"
alias la="ls -aG"
alias ll="ls -lG"
alias rr="rake routes"
alias tmux\ ls="tmux list-sessions"
alias b="bundle"
alias be="bundle exec"
alias r="rails"
alias g="git"
alias fetch="git fetch"
alias pull="git pull"
alias push="git push"
alias clone="git clone"
alias vu="vi"
alias vo="vi"
alias v="vi"
alias coverage="open ./coverage/index.html"

#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'
# tmux自動起動
if [ -z "$TMUX" -a -z "$STY" ]; then
    if type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
            tmux attach && echo "tmux attached session "
        else
            tmux new-session && echo "tmux created new session"
        fi
    fi	
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# hub
eval "$(hub alias -s)"