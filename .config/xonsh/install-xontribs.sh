#!/bin/bash
set -e

echo "📦 Installing xontribs for xonsh..."

if command -v brew >/dev/null 2>&1; then
    brew install xonsh carapace zoxide fzf atuin oh-my-posh

else

echo "could not install xonsh, carapace, zoxide, fzf, atuin, oh-my-posh via brew"

fi

# Find xonsh binary
if command -v xonsh >/dev/null 2>&1; then
    XONSH_BIN="$(command -v xonsh)"
elif [ -f "/opt/homebrew/bin/xonsh" ]; then
    XONSH_BIN="/opt/homebrew/bin/xonsh"
elif [ -f "/usr/local/bin/xonsh" ]; then
    XONSH_BIN="/usr/local/bin/xonsh"
else
    echo "Error: xonsh binary not found!" >&2
    exit 1
fi

# Core xontribs
$XONSH_BIN <<EOF
xpip install setuptools
xpip install xonsh-direnv
xpip install -U xontrib-pipeliner
xpip install -U xontrib-ergopack
xpip install xontrib-argcomplete
xpip install xontrib-fish-completer
xpip install xontrib-termcolors
xpip install xontrib-homebrew
xpip install xontrib-ssh-agent
xpip install -U xontrib-fzf-completions
xpip install -U git+https://github.com/t184256/xontrib-prompt-vi-mode
xpip install xontrib-zoxide
xpip install xontrib-jump-to-dir
xpip install xontrib-clp
xpip install xontrib-cmd-durations
xpip install xontrib-term-integrations
xpip install xontrib-fzf-widgets
xpip install -U xontrib-output-search
xpip install xontrib-langenv
xpip install xontrib-kitty
xpip install xontrib-bash-completions-dirs
xpip install xontrib-makefile-complete
xpip install xonsh-docker-tabcomplete
xpip install xontrib-abbrevs
xpip install xontrib-prompt-starship
xpip install xontrib-whole-word-jumping
xpip install xontrib-powerline3
xpip install -U xontrib-prompt-bar
xpip install xontrib-powerline-binding
EOF

echo "✅ All xontribs installed successfully!"
echo "Restart xonsh to load the new configuration."
