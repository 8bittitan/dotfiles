# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup mise
eval "$(~/.local/bin/mise activate zsh)"

[[ -f "$ZDOTDIR"/.zstyle ]] && source "$ZDOTDIR"/.zstyle

plugins=(
  fzf-tab
  poetry
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

export LS_COLORS="$(vivid generate rose-pine-moon)"

# TODO: Add back once removing oh-my-zsh
# [[ ! -f "$HOME"/fzf-tab/fzf-tab.plugin.zsh ]] && git clone https://github.com/Aloxaf/fzf-tab "$HOME"/fzf-tab
#
# source "$HOME"/fzf-tab/fzf-tab.plugin.zsh

# Install plugins from brew
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Disable homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Keep at end
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(tv init zsh)"
