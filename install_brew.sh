#!/bin/bash

if [[ ! -d /usr/local/Homebrew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  printf "Homebrew directory found!\n"
fi

brew bundle
brew cask reinstall firefox google-chrome