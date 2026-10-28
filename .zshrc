# Bashに近いキー操作（Ctrl+A、Ctrl+Eなど）
bindkey -e

# 履歴の保存と、複数ターミナル間での共有
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Tab補完と候補の選択
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# ディレクトリ名だけで移動
setopt AUTO_CD

# ユーザー名、現在地、入力記号を表示
PROMPT='%F{green}%n%f:%F{blue}%~%f %# '

# PATHの重複を防ぐ（各ツールのパスはlocal設定で管理）
typeset -U path PATH

# Bashで使っていた色分けとalias
if (( $+commands[dircolors] )); then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
fi
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias cmpcpp='g++ -std=gnu++2b -Wall -Wextra -Wshadow -fsanitize=address,undefined -I ~/CompetitiveProgramming/library/ -I ~/CompetitiveProgramming/ac-library -DLOCAL -g'

# lessで圧縮ファイルなどを開けるようにする
if [[ -x /usr/bin/lesspipe ]]; then
  eval "$(SHELL=/bin/sh /usr/bin/lesspipe)"
fi

# このPCの環境変数・ツール初期化（Git管理しない）
if [[ -r "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi

# 履歴から入力候補を表示（行末で右矢印を押すと採用）
source ~/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# 入力中のコマンドを色分け（最後に読み込む）
source ~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
