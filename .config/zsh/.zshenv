export CARGOPATH="$HOME/.cargo/bin"
export COLUMNS
export EDITOR='nvim'
export GPG_TTY=$TTY
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PAGER='bat'
export VISUAL='nvim' # editor to be opened from $PAGER
export XDG_CONFIG_HOME=$HOME/.config
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export TAILSPIN_PAGER="ov -f [FILE]"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm";
export PATH="$PNPM_HOME:$PATH";

# PHP
export PATH="$HOME/.config/composer/vendor/bin:$PATH";

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Opencode
export PATH=~/.opencode/bin:$PATH
export PATH="/Users/pauljankowski/.bun/bin:$PATH"

export FZF_COMPLETION_TRIGGER=',,'
export FZF_DEFAULT_COMMAND='rga --files --hidden -g "!{node_modules,.git,.vscode,.cache,.terraform,.DS_Store,.Trash,.terraform.d,.npm,.dotfiles,.nvm}"'
export FZF_PREVIEW_COLUMNS
export FZF_TMUX_OPTS=" -p90%,70% "
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --border=none \
  --preview-window=top,70%:wrap \
  "
export FORGIT_FZF_DEFAULT_OPTS="
--cycle
--preview-window 'top:wrap'
--height '90%'
"
