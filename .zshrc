# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
# CANGE THESE
export ZSH=/Users/pauljankowski/.oh-my-zsh

# CANGE THIS
ZSH_CUSTOM="/Users/pauljankowski/.oh-my-zsh/custom"
plugins=(git npm node yarn zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# CHANGE THESE
# export PATH=/Users/pjankowski/Desktop/development/mongodb/bin:$PATH
# export GOPATH=/Users/pauljankowski/projects/go

# Bash
alias ll='ls -al';
alias c='clear';
alias ~='cd ~';
alias zconf='source ~/.zshrc';

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

# Athia
alias athia='cd ~/projects/athia';
alias athia-api='cd ~/projects/athia-api';

# Laravel
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'

# ANY WORK RELATED ONES

export NVM_DIR="/usr/local/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Go
export PATH="/usr/local/go:$PATH"

# Laravel
export PATH="~/.composer/vendor/bin:$PATH"


# Startship
eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"