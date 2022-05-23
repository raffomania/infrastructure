#!/usr/bin/oil
shopt --set xtrace

# basic usability
if ($SHELL !== "/usr/bin/zsh") {
    try chsh -s /usr/bin/zsh
}

ln -sf $HOME/infrastructure/config/.zshrc $HOME/.zshrc
ln -sf $HOME/infrastructure/config/.zprofile $HOME/.zprofile

# ssh
sudo sed -i 's/#Port/Port/' /etc/ssh/sshd_config
sudo sed -i 's/Port .*/Port 7022/' /etc/ssh/sshd_config

# nftables
sudo cp $_this_dir/../config/nftables.conf /etc/nftables.conf
sudo systemctl enable --now nftables

# wireguard
sudo cp $_this_dir/../config/wg0.conf /etc/wireguard/wg0.conf
var privkey = $(sudo cat /root/$(hostname).key)
sudo sed -i "s%PrivateKey =\$%PrivateKey = $privkey%" /etc/wireguard/wg0.conf
sudo systemctl enable --now wg-quick@wg0

# podman
sudo touch /etc/subuid /etc/subgid
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 rafael
sudo sysctl net.ipv4.ip_unprivileged_port_start=80
sudo podman system migrate

systemctl enable --user podman-restart.service
sudo loginctl enable-linger rafael