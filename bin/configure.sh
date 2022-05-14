#!/usr/bin/oil
shopt --set xtrace

try chsh -s /usr/bin/zsh

ln -sf $HOME/infrastructure/.zshrc $HOME/.zshrc
ln -sf $HOME/infrastructure/.zprofile $HOME/.zprofile