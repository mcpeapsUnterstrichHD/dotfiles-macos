#!/bin/sh

# update brewfile

brewfile > ./packages-to-intalled

# synchronizing dotfiles
stow .