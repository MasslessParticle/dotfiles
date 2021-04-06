#!/bin/bash

. ~/workspace/dotfiles/support/helpers.sh

identify_package "npm" 6.14.8

if [[ `npm --version` = "$VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt install nodejs npm
  mkdir ~/.npm
  npm config set prefix $HOME/.npm
end_install
