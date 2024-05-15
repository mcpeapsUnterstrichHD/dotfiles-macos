#!/bin/sh
#only run this on macos
#only run this on fresh install

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install packages
brew bundle --file=./packages-to-intalled --cask

# install brewfile
gem install brewfile


# synchronizing dotfiles
stow -t ~ . --adopt

# chmod the hangman
chmod +x ./hangman
