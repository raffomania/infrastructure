#!/usr/bin/oil
shopt --set xtrace

# basic usability
try chsh -s /usr/bin/zsh

ln -sf $HOME/infrastructure/.zshrc $HOME/.zshrc
ln -sf $HOME/infrastructure/.zprofile $HOME/.zprofile

# networking
sudo sed -i 's/#Port/Port/' /etc/ssh/sshd_config
sudo sed -i 's/Port .*/Port 7022/' /etc/ssh/sshd_config
# todo disallow root login

sudo cp $_this_dir/../nftables.conf /etc/nftables.conf
sudo systemctl enable --now nftables

sudo cp $_this_dir/../wg0.conf /etc/wireguard/wg0.conf
var privkey = $(sudo cat /root/$(hostname).key)
sudo sed -i "s%PrivateKey =\$%PrivateKey = $privkey%" /etc/wireguard/wg0.conf
sudo systemctl enable --now wg-quick@wg0