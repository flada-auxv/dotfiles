# エイリアス読み込み
dotfiles_dir=$HOME/dotfiles
source $dotfiles_dir/zsh_aliases

# 重複パスを登録しない
typeset -U path cdpath fpath manpath

# EDITORをvimにするとターミナル上のバインドまでvimっぽくなるので
bindkey -e

# 補完の設定
autoload -U compinit
compinit

# zsh-completions
fpath=($dotfiles_dir/zsh-completions(N-/) ${fpath})

setopt auto_cd  # ディレクトリ名のみでcdできる
setopt auto_pushd # "cd -" でtabを押すと移動履歴のリストが表示される
setopt correct # コマンドのスペルチェック
setopt no_beep # ビープ音を鳴らない様にする

autoload -U colors; colors
# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%{${reset_color}%}"
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

# olivierverdier/zsh-git-prompt
source ~/.zsh/git-prompt/zshrc.sh
PROMPT='${tmp_prompt}$(git_super_status) %# '
#PROMPT='%B%m%~%b$(git_super_status) %# '

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history 

# コマンド履歴検索のショートカットをC-nとC-pに
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

