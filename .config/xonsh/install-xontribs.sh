#!/bin/bash
# Xonsh Xontribs Installation Script
# Run this script to install all xontribs for your xonsh shell

set -e

echo "📦 Installing xontribs for xonsh..."

# Make sure xpip is available (xonsh's pip wrapper)
# If using regular pip with xonsh virtualenv, use pip instead of xpip

# Core xontribs
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

# Carapace (shell completion engine) - install via Homebrew
echo "📦 Installing carapace via Homebrew..."
brew install carapace

echo "✅ All xontribs installed successfully!"
echo ""
echo "Note: Some xontribs may require additional tools to be installed:"
echo "  - zoxide: brew install zoxide"
echo "  - fzf: brew install fzf"
echo "  - atuin: brew install atuin"
echo "  - oh-my-posh: brew install oh-my-posh"
echo ""
echo "Restart xonsh to load the new configuration."
