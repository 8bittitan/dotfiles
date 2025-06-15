alias -s {js,json,yaml,html,css,toml}='bat'

# General
alias f='fzf | xargs -I{} nvim {}'
alias fzf='fzf --preview "([[ -f {} ]] && (bat --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"'
alias c='clear';
alias ~='cd ~';
alias zconf='source ~/.zshrc';
alias v='nvim';

# Eza
alias l="eza -lbha --icons --group-directories-first --hyperlink --color-scale=size"
alias ll="l"
alias lt="eza -TlbhaF --git --icons --group-directories-first --level=2"

# Git
alias push='git push';
alias pull='git pull';
alias gs='git status';
alias develop='git checkout develop';
alias staging='git checkout staging';
alias master='git checkout master';
alias commit='git commit';
alias co='git checkout';

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
