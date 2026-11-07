# Cache a tool's init script; regenerate only when the binary is newer
_cached_init() {
  emulate -L zsh
  local name="$1" bin="$2"; shift 2
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/init"
  local out="$cache_dir/$name.zsh"
  local binfile="${commands[$bin]}"
  [[ -d $cache_dir ]] || mkdir -p "$cache_dir"
  [[ -z $binfile ]] && return 0
  if [[ ! -s $out || $binfile -nt $out ]]; then
    "$binfile" "$@" >| "$out" || { rm -f "$out"; return 1; }
  fi
  source "$out"
}

zsh-refresh-init() { rm -rf "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/init"; exec zsh }

export HOMEBREW_PREFIX=/opt/homebrew HOMEBREW_CELLAR=/opt/homebrew/Cellar HOMEBREW_REPOSITORY=/opt/homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# Setup mise
_cached_init mise mise activate zsh

[[ -f "$ZDOTDIR"/.zstyle ]] && source "$ZDOTDIR"/.zstyle

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
if [ ! -d "$HOMEBREW_PREFIX/bin/vault" ]; then
  complete -o nospace -C /opt/homebrew/bin/vault vault;
fi

_cached_init kubectl   kubectl  completion zsh
_cached_init fzf       fzf      --zsh
_cached_init ov        ov       --completion zsh
_cached_init tspin     tspin    --completions zsh
_cached_init wt        wt       config shell init zsh
_cached_init gopass    gopass   completion zsh
_cached_init starship  starship init zsh
_cached_init atuin     atuin    init zsh
_cached_init zoxide    zoxide   init zsh
_cached_init tv        tv       init zsh

bindkey -v

export LS_COLORS="$(vivid generate rose-pine-moon)"

[[ -d ~/.local/share/zsh/fzf-tab ]] || git clone --depth 1 https://github.com/Aloxaf/fzf-tab ~/.local/share/zsh/fzf-tab
source ~/.local/share/zsh/fzf-tab/fzf-tab.plugin.zsh

# Install plugins from brew
source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Disable homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
