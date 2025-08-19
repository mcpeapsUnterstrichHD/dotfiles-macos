emulate sh
source ~/.profile
emulate zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$PATH:/Applications

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
eval "$(/opt/homebrew/bin/brew shellenv)"

