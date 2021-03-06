#!/bin/bash

. ~/workspace/dotfiles/support/helpers.sh

identify_package "chruby" 0.3.9

if [[ `chruby-exec --version` = "chruby version $VERSION" ]]; then
    echo_already_installed
    exit
fi

start_install
  wget -O chruby-$VERSION.tar.gz https://github.com/postmodern/chruby/archive/v$VERSION.tar.gz
  tar -xzvf chruby-$VERSION.tar.gz
  pushd chruby-$VERSION/
    sudo make install
  popd
  rm chruby-$VERSION.tar.gz
  rm -rf chruby-$VERSION
end_install
