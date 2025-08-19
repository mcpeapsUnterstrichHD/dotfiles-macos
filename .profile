eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#. "$HOME/.cargo/env"
export PATH=$PATH:/Applications
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/mahd/.lmstudio/bin"
# End of LM Studio CLI section

