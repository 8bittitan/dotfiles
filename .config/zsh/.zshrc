eval "$(mise env)"

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Setup mise
eval "$(~/.local/bin/mise activate zsh)"
eval "$(mise hook-env)"

[[ -f "$ZDOTDIR"/.zstyle ]] && source "$ZDOTDIR"/.zstyle

plugins=(
  fzf-tab
  )

[[ -f "$ZSH"/oh-my-zsh.sh ]] && source "$ZSH"/oh-my-zsh.sh
autoload -U add-zsh-hook

helper_files=(
  "$ZDOTDIR"/aliases.zsh
  "$ZDOTDIR"/.zsh_opts
  "$ZDOTDIR"/.zshenv.local
)

for file in $helper_files; do
  [[ -f $file ]] && source $file
done

eval "$(/opt/homebrew/bin/brew shellenv)"

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit

# only check it once a day to see if it's changed
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# MUST BE BELOW COMPLETIONS
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(kubectl completion zsh)
eval "$(fzf --zsh)"

bindkey -v

# pnpm
export PNPM_HOME="/Users/pauljankowski/Library/pnpm";
export PATH="$PNPM_HOME:$PATH";
# pnpm end

# Install plugins from brew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Google Cloud
if [ -f '/Users/pauljankowski/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pauljankowski/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/pauljankowski/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pauljankowski/google-cloud-sdk/completion.zsh.inc'; fi

# PHP
export PATH="$HOME/.composer/vendor/bin:$PATH";
# Herd injected PHP binary.
export PATH="/Users/pauljankowski/Library/Application Support/Herd/bin/":$PATH
export PHP_INI_SCAN_DIR="/Users/pauljankowski/Library/Application Support/Herd/config/php/":$PHP_INI_SCAN_DIR
# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/pauljankowski/Library/Application Support/Herd/config/php/82/"
# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/pauljankowski/Library/Application Support/Herd/config/php/83/"
# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/pauljankowski/Library/Application Support/Herd/config/php/84/"

# Disable homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# Keep at end
eval "$(starship init zsh)"

