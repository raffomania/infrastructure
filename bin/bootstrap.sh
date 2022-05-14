#!/bin/sh
set -euxo pipefail

passwd root

pacman -S oil git
git clone https://github.com/raffomania/infrastructure
rm bootstrap.sh