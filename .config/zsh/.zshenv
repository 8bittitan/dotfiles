export CARGOPATH="$HOME/.cargo/bin"
export COLUMNS
export COMPLETION_WAITING_DOTS="true"
export DISABLE_AUTO_TITLE=true
export EDITOR='nvim'
export GPG_TTY=$TTY
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PAGER='bat'
export TERM="xterm-256color" # This sets up colors properly
export UPDATE_ZSH_DAYS=1
export VISUAL='nvim' # editor to be opened from $PAGER
export VI_MODE_SET_CURSOR=true
export XDG_CONFIG_HOME=$HOME/.config
export ZSH="$HOME/.oh-my-zsh"
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export GOPATH="$HOME/projects/"

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export FZF_COMPLETION_TRIGGER=',,'
export FZF_DEFAULT_COMMAND='rga --files --hidden -g "!{node_modules,.git,.vscode,.cache,.terraform,.DS_Store,.Trash,.terraform.d,.npm,.dotfiles,.nvm}"'
export FZF_PREVIEW_COLUMNS
export FZF_TMUX_OPTS=" -p90%,70% "
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --preview-window=top,70%:wrap \
  "
export FORGIT_FZF_DEFAULT_OPTS="
--cycle
--preview-window 'top:wrap'
--height '90%'
"
