#!/bin/sh
set -euxo pipefail

passwd root

pacman -S --needed oil git
git clone https://github.com/raffomania/infrastructure
./infrastructure/bin/syncpkgs.sh
./infrastructure/bin/configure.sh
rm bootstrap.sh