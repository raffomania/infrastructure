#!/usr/bin/oil
shopt --set xtrace

# basic usability
try chsh -s /usr/bin/zsh

ln -sf $HOME/infrastructure/.zshrc $HOME/.zshrc
ln -sf $HOME/infrastructure/.zprofile $HOME/.zprofile

# networking
sed -i 's/#Port/Port/' /etc/ssh/sshd_config
sed -i 's/Port .*/Port 7022/' /etc/ssh/sshd_config

cp $_this_dir/../nftables.conf /etc/nftables.conf
systemctl enable nftables

if ! test --file /etc/wireguard/wg0.conf {
    cp $_this_dir/../wg0.conf /etc/wireguard/wg0.conf
}
systemctl enable wg-quick@wg0