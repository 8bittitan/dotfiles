# CANGE THESE
export ZSH=/Users/jankowp/.oh-my-zsh
export ANDROID_HOME=/Users/jankowp/Library/Android/sdk

ZSH_THEME="dracula"

# CANGE THIS
ZSH_CUSTOM="/Users/jankowp/.oh-my-zsh/custom"
plugins=(git npm node yarn zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# CHANGE THESE
# export PATH=/Users/pjankowski/Desktop/development/mongodb/bin:$PATH
export GOPATH=/Users/jankowp/projects/go
export PATH="/Users/jankowp/Library/Android/sdk/platform-tools":$PATH

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

#work
alias work='cd ~/projects/vagrant';
alias nolo='cd ~/projects/vagrant/workspace/nolo-us-en';
alias g='gulp';
alias gh='gulp handlebars';
alias gc='gulp css';
alias gn='gulp njk';
alias gj='gulp js';
alias gnc='gulp njk css';

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

