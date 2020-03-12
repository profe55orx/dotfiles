#!/bin/bash

curl -s "https://get.sdkman.io" | zsh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk i java 8.0.242.hs-adpt
sdk i java 11.0.6.hs-adpt
sdk i maven
sdk i gradle
sdk i springboot