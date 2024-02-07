# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/profile.pre.bash"
eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/profile.post.bash" ]] && builtin source "$HOME/.fig/shell/profile.post.bash"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
