#!/usr/bin/ysh
shopt --set xtrace

## Idempotent script to update system config to the desired state.
# Does not restart services on configuration changes

# basic usability
if ("$SHELL" !== "/usr/bin/zsh") {
    try chsh -s /usr/bin/zsh
}

# user config files
ln -sf $HOME/infrastructure/config/.zshrc $HOME/.zshrc
ln -sf $HOME/infrastructure/config/.zprofile $HOME/.zprofile
ln -sf $HOME/infrastructure/config/.gitconfig $HOME/.gitconfig
ln -sf $HOME/infrastructure/config/.ssh/authorized_keys $HOME/.ssh/authorized_keys

mkdir -p ~/backups

# ssh
sudo sed -i 's/#*Port .*/Port 7022/' /etc/ssh/sshd_config
sudo sed -i 's/#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/#*KbdInteractiveAuthentication.*/KbdInteractiveAuthentication no/' /etc/ssh/sshd_config

# nftables
sudo cp $_this_dir/../config/nftables.conf /etc/nftables.conf
sudo systemctl enable --now nftables

# pacman
sudo sed -i 's/#VerbosePkgLists.*/VerbosePkgLists/' /etc/pacman.conf

# podman
# todo: I think these settings are now the default
sudo touch /etc/subuid /etc/subgid
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 rafael

sudo sysctl net.ipv4.ip_unprivileged_port_start=80
echo "net.ipv4.ip_unprivileged_port_start=80" | sudo tee /etc/sysctl.d/01-ports.conf
sudo podman system migrate
# For docker-compose
sudo sed -i 's/#*compose_warning_logs.*/compose_warning_logs = false/' /etc/containers/containers.conf
systemctl --user enable podman.socket

systemctl enable --user podman-restart.service
sudo loginctl enable-linger rafael
