#!/bin/bash

. ~/workspace/dotfiles/support/helpers.sh

identify_package "ripgrep" 12.1.1

if [[ `rg --version | head -n1` == "ripgrep $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt install ripgrep
end_install
