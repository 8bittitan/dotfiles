alias -s {js,json,yaml,html,css,toml}='bat'
alias -s git='git clone'

alias -g G="| rga --hyperline-format=kitty"
alias -g C="| wc -l"

# General
alias cat='bat'
alias f='fzf | xargs -I{} nvim {}'
alias fz="fzf_custom"
alias c='clear';
alias ~='cd ~';
alias zconf='source ~/.zshrc';
alias v='nvim';

# Eza
alias l="eza -lbha -o --icons --group-directories-first --hyperlink --color-scale=size"
alias ll="l"
alias lt="eza -TlbhaF --git --icons --group-directories-first --level=2"

# Git
alias lg='lazygit';
alias push='git push';
alias pull='git pull';
alias gs='git status';
alias develop='git checkout develop';
alias staging='git checkout staging';
alias master='git checkout master';
alias commit='git commit';
alias co='git checkout';
alias gd="gh dash";

# Random
alias myip='curl ip.appspot.com';

# Dev
alias start='npm start';
alias dev='npm run dev';
alias build='npm run build';
alias py='python3';

# PHP
alias art='php artisan';
alias pest='./vendor/bin/pest';
alias lara='~/.composer/vendor/bin/laravel';

# Docker
alias dcu="docker compose up"

fzf_custom() {
  fzf --preview "([[ -f {} ]] && (bat --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"
}
