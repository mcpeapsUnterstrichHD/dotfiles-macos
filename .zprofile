emulate sh
source ~/.profile
emulate zsh
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$PATH:/Applications

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
eval "$(/opt/homebrew/bin/brew shellenv)"


##
# Your previous /Users/mahd/.zprofile file was backed up as /Users/mahd/.zprofile.macports-saved_2025-10-18_at_18:15:12
##

# MacPorts Installer addition on 2025-10-18_at_18:15:12: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

