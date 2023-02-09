#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

. ~/workspace/dotfiles/support/helpers.sh

echo_header "apt-get"

echo_step "add external ubuntu repositories"
sudo add-apt-repository ppa:neovim-ppa/unstable -y

echo_step "update"
sudo apt-get update

echo_step "install dependencies"
sudo apt-get install -qq -y automake autoconf autotools-dev build-essential pkg-config cmake net-tools
sudo apt-get install -qq -y tmux git curl htop tree silversearcher-ag openssh-server
sudo apt-get install -qq -y python3 python3-pip jq
sudo apt-get install -qq -y libxml2 libxml2-dev libcurl4-gnutls-dev
sudo apt-get install -qq -y fonts-inconsolata gnome-tweaks httpie
sudo apt-get install -qq -y direnv neovim xclip

echo_footer "finished apt-get"

echo_step "install packages"
for package in packages/*.sh
do
  $package
done

. ~/workspace/dotfiles/support/helpers.sh

# pull down plug.vim so we can manage all our other vim plugins
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install patched fonts for powerline
echo_header "Installing fonts"

# Refresh the font cache
sudo fc-cache -fv >/dev/null

echo_header "you may be prompted by a sudo password now"
git clone https://github.com/powerline/fonts.git --depth=1
pushd fonts
  ./install.sh
popd
rm -rf fonts
echo_footer "fonts installed"

SRC=$HOME/workspace/dotfiles/config

mkdir -p $HOME/.config/nvim

echo_header "link dotfiles"
ln -sf $SRC/init.vim $HOME/.config/nvim/init.vim
ln -sf $SRC/coc-settings.json $HOME/.config/nvim.coc-settings.json

rcup -fv -x gitconfig -x init.vim -d config
echo_footer "dotfiles linked"

echo_header "post install"

source $HOME/.profile
source $HOME/.bash_profile
source $HOME/.bashrc
source $HOME/.aliases

./post-install.sh

echo_header "Install NeoVim plugins"
nvim +PlugInstall +GoInstallBinaries +qall
echo_footer "NeoVim plugins installed"

rm -f $HOME/.gitconfig
git config --global include.path "$SRC"/gitconfig
