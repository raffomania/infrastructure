#!/bin/sh
set -euxo pipefail

# todo: add cd $(dirname $0)?

## Initial bootstrap script for a completely fresh installation
## of arch linux on a hetzner server.

# Install dependencies
pacman --noconfirm -S --needed oil git sudo

# Set root password
passwd root

# Allow sudo for normal user
groupadd sudo || true
useradd -G sudo -m rafael || true
echo '%sudo ALL=(ALL:ALL) ALL' > /etc/sudoers.d/sudo-group

# Add SSH key for normal user
sudo -u rafael mkdir -p /home/rafael/.ssh
cp /root/.ssh/authorized_keys /home/rafael/.ssh/authorized_keys
chown rafael /home/rafael/.ssh/authorized_keys

# Set normal user's password
passwd rafael

# Clone infra repo
sudo -u rafael git clone https://github.com/raffomania/infrastructure /home/rafael/infrastructure || true

# Install all required packages
sudo -u rafael /home/rafael/infrastructure/bin/syncpkgs.sh

# Set standard configuration
sudo -u rafael /home/rafael/infrastructure/bin/configure.sh

# Remove bootstrap script
rm bootstrap.sh
