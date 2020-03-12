#!/bin/bash

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install neovim
nvim +'PlugInstall --sync' +qa
nvim +'PlugUpdate --sync' +qa
nvim +'PlugUpgrade --sync' +qa
nvim +'GoInstallBinaries --sync' +qa