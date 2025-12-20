# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

PATH=~/.console-ninja/.bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/mahd/.lmstudio/bin"
# End of LM Studio CLI section

source ${HOME}/.ghcup/env
