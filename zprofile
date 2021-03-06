# ログインシェルとして起動された場合のみ読み込まれる

export LANG=ja_JP.UTF-8
export EDITOR=/usr/local/bin/vim
export BUNDLER_EDITOR=subl

# HomeBrewコマンドのインストール先("/usr/local/bin or sbin")を優先する
# ついでにホームディレクトリのbinも追加
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH

### Heroku Toolbelt
if which heroku > /dev/null 2>&1; then
  export PATH=/usr/local/heroku/bin:$PATH
fi

### PpostrgreSQL
if which postgres > /dev/null 2>&1; then
  export PGDATA=/usr/local/var/postgres
fi

# PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'
### tmux自動起動
if [ -z "$TMUX" -a -z "$STY" ]; then
    if type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
            tmux attach && echo "tmux attached session"
        else
            tmux new-session && echo "tmux created new session"
        fi
    fi
fi

# autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=`brew --prefix openssl` --with-readline-dir=`brew --prefix readline`"

