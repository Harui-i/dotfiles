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

# ツールのPATH（重複は取り除く）
typeset -U path PATH
[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"
[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
path=(
  "$HOME/.kimi-code/bin"
  "$HOME/.local/bin"
  "$HOME/bin"
  $path
  "$HOME/.lmstudio/bin"
  /opt/nvim-linux-x86_64/bin
  "$HOME/.elan/bin"
)
export PATH

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
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cmpcpp='g++ -std=gnu++2b -Wall -Wextra -Wshadow -fsanitize=address,undefined -I ~/CompetitiveProgramming/library/ -I ~/CompetitiveProgramming/ac-library -DLOCAL -g'

# lessで圧縮ファイルなどを開けるようにする
if [[ -x /usr/bin/lesspipe ]]; then
  eval "$(SHELL=/bin/sh /usr/bin/lesspipe)"
fi

# Node.js（nvmの補完はzshにも対応）
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# GPGが現在のターミナルを使うようにする
if [[ -t 0 ]]; then
  export GPG_TTY="$(tty)"
fi

# 認証情報など、このPCだけの設定（Git管理しない）
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/harui/.juliaup/bin' $path)
export PATH
# Tab completion for juliaup and julia channel selection
[ -f "/home/harui/.julia/juliaup/completions/zsh.zsh" ] && source "/home/harui/.julia/juliaup/completions/zsh.zsh"

# <<< juliaup initialize <<<

# ディレクトリに応じた環境変数の切り替え（zsh用のhook）
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi

# 履歴から入力候補を表示（行末で右矢印を押すと採用）
source ~/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# 入力中のコマンドを色分け（最後に読み込む）
source ~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
