#! /usr/bin/env bash
set -e

brew install fish

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

omf install bang-bang brew z zoxide nvm ssh-agent pisces

omf theme install agnoster
