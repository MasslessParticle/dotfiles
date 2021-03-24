#!/bin/bash

. ~/workspace/dotfiles/support/helpers.sh

identify_package "silver-searcher" 2.2.0

if [[ `ag --version | head -n1` == "ag version $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt install silversearcher-ag
end_install
