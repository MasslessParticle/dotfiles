#!/bin/bash

. ~/workspace/dotfiles/support/helpers.sh

identify_package "openvpn" "2.4.9"

if [[ `openvpn --version | head -1` = "OpenVPN $VERSION "* ]]; then
    echo_already_installed
    exit
fi

start_install
  sudo apt-get install -y openvpn
end_install
