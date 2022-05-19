#!/bin/sh
set -euxo pipefail

pacman --noconfirm -S --needed oil git sudo

passwd root

groupadd sudo || true
useradd -G sudo -m rafael || true
echo '%sudo ALL=(ALL:ALL) ALL' > /etc/sudoers.d/sudo-group
sudo -u rafael mkdir -p /home/rafael/.ssh
cp /root/.ssh/authorized_keys /home/rafael/.ssh/authorized_keys
chown rafael /home/rafael/.ssh/authorized_keys
passwd rafael

sudo -u rafael git clone https://github.com/raffomania/infrastructure /home/rafael/infrastructure || true
sudo -u rafael /home/rafael/infrastructure/bin/syncpkgs.sh
sudo -u rafael /home/rafael/infrastructure/bin/configure.sh
rm bootstrap.sh