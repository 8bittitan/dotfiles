eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup mise
eval "$(~/.local/bin/mise activate zsh)"

[[ -f "$ZDOTDIR"/.zstyle ]] && source "$ZDOTDIR"/.zstyle

autoload -U add-zsh-hook

helper_files=(
  "$ZDOTDIR"/aliases.zsh
  "$ZDOTDIR"/.zsh_opts
  "$ZDOTDIR"/.zshenv.local
)

for file in $helper_files; do
  [[ -f $file ]] && source $file
done

fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)

autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit

typeset -g ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION"
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}

if [[ ! -f $ZSH_COMPDUMP ]] || [[ -n $ZSH_COMPDUMP(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
  zcompile -Uz "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi

# MUST BE BELOW COMPLETIONS
# vault ships a bash-style dynamic completion; needs bashcompinit + compinit
complete -o nospace -C /opt/homebrew/bin/vault vault;
source <(kubectl completion zsh)
eval "$(fzf --zsh)"
eval "$(ov --completion zsh)"
eval "$(tspin --completions zsh)"
eval "$(wt config shell init zsh)"
eval "$(gopass completion zsh)"

bindkey -v

export LS_COLORS="$(vivid generate rose-pine-moon)"

[[ ! -f ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh ]] && git clone https://github.com/Aloxaf/fzf-tab ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh

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
