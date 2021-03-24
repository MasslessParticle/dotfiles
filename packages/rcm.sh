#!/bin/bash

. ~/workspace/dotfiles/support/helpers.sh

identify_package "rcm" 1.3.3

if [[ `rcup -V | head -n1` == "rcup (rcm) $VERSION"* ]]; then
    echo_already_installed
    exit
fi

start_install
    sudo apt install rcm
end_install
