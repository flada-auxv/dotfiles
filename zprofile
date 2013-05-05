export LANG=ja_JP.UTF-8
export EDITOR=vim
export BUNDLER_EDITOR=subl

# rbenv
if which rbenv > /dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# HomeBrewコマンドのインストール先("/usr/local/bin or sbin")を優先する
# ついでにホームディレクトリにもbinを
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH"

### for Heroku Toolbelt
if which heroku > /dev/null 2>&1; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

### for postrgresql
if which postgres > /dev/null 2>&1; then
  export PGDATA=/usr/local/var/postgres
fi

#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'
# tmux自動起動
if [ -z "$TMUX" -a -z "$STY" ]; then
    if type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
            tmux attach && echo "tmux attached session"
        else
            tmux new-session && echo "tmux created new session"
        fi
    fi
fi
